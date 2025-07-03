import Foundation
import Capacitor

@objc(CapacitorEventBirdPlugin)
public class CapacitorEventBirdPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CapacitorEventBirdPlugin"
    public let jsName = "CapacitorEventBird"

    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "logout", returnType: CAPPluginReturnPromise),
    ]

    private var pendingEchoCalls: [CAPPluginCall] = []
    private var savedToken: String?
    private let implementation = CapacitorEventBird()

    @objc func echo(_ call: CAPPluginCall) {
        if let token = savedToken {
            call.resolve(["value": token])
        } else {
            print("[Native] JS called echo, but token not ready. Queuing callback.")
            pendingEchoCalls.append(call)
        }
    }

    @objc public func setAuthToken(_ token: String) {
        print("[Native] Setting auth token in plugin")
        self.savedToken = token

        // Resolve all pending echo calls
        for call in pendingEchoCalls {
            call.resolve(["value": token])
        }
        pendingEchoCalls.removeAll()
    }

    @objc public func removeAuthToken() {
        print("[Native] Removing auth token in plugin")
        self.savedToken = nil
    }

    @objc func logout(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("NativeLogoutEvent"), object: nil)
        call.resolve()
    }
}
