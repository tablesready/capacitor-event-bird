import Foundation
import Capacitor

@objc(CapacitorEventBirdPlugin)
public class CapacitorEventBirdPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CapacitorEventBirdPlugin"
    public let jsName = "CapacitorEventBird"

    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "logout", returnType: CAPPluginReturnPromise)
    ]

    // Register the supported events
    public let pluginEvents: [CAPPluginEvent] = [
        CAPPluginEvent(name: "authTokenReceived", returnType: CAPPluginReturnCallback)
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
}
