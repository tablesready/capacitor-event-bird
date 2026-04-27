import Foundation
import Capacitor
import UIKit

@objc(CapacitorEventBirdPlugin)
public class CapacitorEventBirdPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CapacitorEventBirdPlugin"
    public let jsName = "CapacitorEventBird"

    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "getFCMToken", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "waitlistAfterInit", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "openHelpModal", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getDeviceId", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "signupWithGoogle", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "saveCredentials", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getFontScale", returnType: CAPPluginReturnPromise),
    ]

    override public func load() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contentSizeCategoryDidChange),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private var pendingFCMCalls: [CAPPluginCall] = []
    private var pendingGoogleCalls: [CAPPluginCall] = []
    private var pendingSaveCredentialsCall: [CAPPluginCall] = []

    private var savedFCMToken: String?

    @objc func saveCredentials(_ call: CAPPluginCall) {
        let username = call.getString("username") ?? ""
        let password = call.getString("password") ?? ""

        NotificationCenter.default.post(name: Notification.Name("SaveCredentials"), object: ["username": username, "password": password])
        pendingSaveCredentialsCall.append(call)
    }

    @objc public func saveCredentialsResult(_ isSuccess: Bool) {
        print("[Native] saveCredentialsResult()")

        for call in pendingSaveCredentialsCall {
            call.resolve(["isSuccess": isSuccess])
        }
        pendingSaveCredentialsCall.removeAll()
    }

    @objc func getFCMToken(_ call: CAPPluginCall) {
        if let token = savedFCMToken {
            print("[Native] JS called getFCMToken, passing the token.")
            call.resolve(["value": token])
        } else {
            print("[Native] JS called getFCMToken, but token not ready. Queuing callback.")
            pendingFCMCalls.append(call)
        }
    }

    @objc func getDeviceId(_ call: CAPPluginCall) {
        call.resolve(["value": UIDevice.current.identifierForVendor?.uuidString])
        return
    }

    @objc func signupWithGoogle(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("CapacitorSignupWithGoogle"), object: nil)
        print("[Native] JS called getGoogleData, sending CapacitorSignupWithGoogle event")
        pendingGoogleCalls.append(call)
    }

    @objc public func setGoogleUserData(_ displayName: String, _ email: String, _ token: String) {
        print("[Native] setGoogleUserData in plugin")
        for call in pendingGoogleCalls {
            call.resolve(["displayName": displayName, "email": email, "firebaseToken": token])
        }
        pendingGoogleCalls.removeAll()
    }

    @objc public func setFCMToken(_ token: String) {
        print("[Native] Setting FCM token in plugin")
        self.savedFCMToken = token

        for call in pendingFCMCalls {
            call.resolve(["value": token])
        }

        pendingFCMCalls.removeAll()
        notifyListeners("fcmTokenRefreshed", data: ["token": token])
    }

    @objc func openHelpModal(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("HelpBeaconOpenEvent"), object: nil)
        call.resolve()
    }

    @objc func waitlistAfterInit(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("WaitlistAfterInit"), object: nil)
        call.resolve()
    }

    @objc func getFontScale(_ call: CAPPluginCall) {
        call.resolve(currentFontScalePayload())
    }

    @objc private func contentSizeCategoryDidChange() {
        notifyListeners("fontScaleChanged", data: currentFontScalePayload())
    }

    private func currentFontScalePayload() -> [String: Any] {
        let category = UIApplication.shared.preferredContentSizeCategory
        return [
            "scale": Self.scale(for: category),
            "category": category.rawValue,
        ]
    }

    private static func scale(for category: UIContentSizeCategory) -> Double {
        let traits = UITraitCollection(preferredContentSizeCategory: category)
        let baseSize: CGFloat = 17
        let scaledSize = UIFontMetrics(forTextStyle: .body)
        .scaledValue(for: baseSize, compatibleWith: traits)
        return Double(scaledSize / baseSize)
    }
}
