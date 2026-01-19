import Foundation
import Capacitor

@objc(CapacitorEventBirdPlugin)
public class CapacitorEventBirdPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CapacitorEventBirdPlugin"
    public let jsName = "CapacitorEventBird"

    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getFCMToken", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "logout", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "signupWithGoogle", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "waitlistAfterInit", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "openHelpModal", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getDeviceId", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getGoogleData", returnType: CAPPluginReturnPromise),
    ]

    private var pendingEchoCalls: [CAPPluginCall] = []
    private var pendingFCMCalls: [CAPPluginCall] = []
    private var pendingGoogleCalls: [CAPPluginCall] = []

    private var savedToken: String?
    private var savedFCMToken: String?

    private var savedGoogleDisplayName: String?
    private var savedGoogleEmail: String?
    private var savedFirebaseToken: String?

    private let implementation = CapacitorEventBird()

    @objc func echo(_ call: CAPPluginCall) {
        if let token = savedToken {
            print("[Native] JS called echo, passing the token.")
            call.resolve(["value": token])
        } else {
            print("[Native] JS called echo, but token not ready. Queuing callback.")
            pendingEchoCalls.append(call)
        }
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

    @objc func getGoogleData(_ call: CAPPluginCall) {
        if self.savedGoogleDisplayName != nil && self.savedGoogleEmail != nil  {
            print("[Native] JS called getGoogleData, passing the data.")
            call.resolve(["displayName": self.savedGoogleDisplayName, "email": self.savedGoogleEmail, "firebaseToken": self.savedFirebaseToken])
        } else {
            print("[Native] JS called getGoogleData, but data not ready. Queuing callback.")
            pendingGoogleCalls.append(call)
        }
    }

    @objc public func setGoogleUserData(_ displayName: String, _ email: String, _ token: String) {
        print("[Native] setGoogleUserData in plugin")
        self.savedGoogleDisplayName = displayName
        self.savedGoogleEmail = email
        self.savedFirebaseToken = token

        for call in pendingGoogleCalls {
            call.resolve(["displayName": self.savedGoogleDisplayName, "email": self.savedGoogleEmail, "firebaseToken": self.savedFirebaseToken])
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

    @objc public func setAuthToken(_ token: String) {
        print("[Native] Setting auth token in plugin")
        self.savedToken = token

        for call in pendingEchoCalls {
            call.resolve(["value": token])
        }
        pendingEchoCalls.removeAll()
    }

    @objc func logout(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("NativeLogoutEvent"), object: nil)
        savedToken = nil
        pendingEchoCalls.removeAll()
        call.resolve()
    }

    @objc func signupWithGoogle(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("CapacitorSignupWithGoogle"), object: nil)
        call.resolve()
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
