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

    private let implementation = CapacitorEventBird()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func logout(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate {
                sceneDelegate.showLoginScreen()
                call.resolve()
            } else if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.showLoginScreen()
                call.resolve()
            } else {
                call.reject("Unable to access root view controller")
            }
        }
    }
}
