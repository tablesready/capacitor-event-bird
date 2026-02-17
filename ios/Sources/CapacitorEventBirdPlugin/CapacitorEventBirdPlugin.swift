import Foundation
import Capacitor

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
    ]

    private var pendingFCMCalls: [CAPPluginCall] = []
    private var pendingGoogleCalls: [CAPPluginCall] = []

    private var savedFCMToken: String?

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
    }

    @objc func openHelpModal(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("HelpBeaconOpenEvent"), object: nil)
        call.resolve()
    }

    @objc func waitlistAfterInit(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("WaitlistAfterInit"), object: nil)
        call.resolve()
    }
}
