import Foundation

@objc public class CapacitorEventBird: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
