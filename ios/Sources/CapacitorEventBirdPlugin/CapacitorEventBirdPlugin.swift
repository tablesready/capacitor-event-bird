import Foundation
import Capacitor

@objc(CapacitorEventBirdPlugin)
public class CapacitorEventBirdPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CapacitorEventBirdPlugin"
    public let jsName = "CapacitorEventBird"

    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "logout", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "notifyNativeReady", returnType: CAPPluginReturnPromise),
    ]

    private let implementation = CapacitorEventBird()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func logout(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("NativeLogoutEvent"), object: nil)
        call.resolve()
    }

    // Call this from AppDelegate or native to emit the token to JS
    @objc public func sendAuthTokenToJS(_ token: String) {
        let json = "{ \"token\": \"\(token)\" }"
        bridge?.triggerJSEvent(
            eventName: "authTokenReceived",
            target: "window",
            data: json
        )
    }

    @objc func notifyNativeReady(_ call: CAPPluginCall) {
        print("[Native] JS signaled ready")

        // If we already have a token pending, send it now
        if let token = AppDelegate.shared?.pendingToken {
            sendAuthTokenToJS(token)
            AppDelegate.shared?.pendingToken = nil
        }

        call.resolve()
    }
}
