import Foundation
import StoreKit

/// Reads the App Store storefront country code.
///
/// Merged in from the former `capacitor-store-country` plugin so the app only
/// depends on a single native plugin.
final class StoreCountry: NSObject, SKPaymentTransactionObserver {
    /// Returned when the storefront can't be determined (no App Store account,
    /// or the storefront never becomes available).
    static let unknownCountry = "NIL"

    private static let storefrontTimeout: TimeInterval = 5

    private var callbacks: [(String) -> Void] = []

    /// Resolves the storefront country. The callback is always invoked on the
    /// main thread, exactly once.
    func getCountryCode(_ callback: @escaping (String) -> Void) {
        DispatchQueue.main.async {
            // Usually available straight away.
            if let storefront = SKPaymentQueue.default().storefront {
                callback(storefront.countryCode)
                return
            }

            self.callbacks.append(callback)
            guard self.callbacks.count == 1 else { return }

            SKPaymentQueue.default().add(self)

            // Without this the JS promise would hang forever when the
            // storefront never becomes available.
            DispatchQueue.main.asyncAfter(deadline: .now() + Self.storefrontTimeout) { [weak self] in
                self?.finish(with: Self.unknownCountry)
            }
        }
    }

    // MARK: - SKPaymentTransactionObserver

    func paymentQueue(
        _ queue: SKPaymentQueue,
        updatedTransactions transactions: [SKPaymentTransaction]
    ) {
        // Required by the protocol; this observer only watches the storefront.
    }

    func paymentQueueDidChangeStorefront(_ queue: SKPaymentQueue) {
        finish(with: queue.storefront?.countryCode ?? Self.unknownCountry)
    }

    /// Drains every waiter. Serialised on the main queue, so the `isEmpty`
    /// guard makes this safe to call from both the timeout and the observer.
    private func finish(with country: String) {
        DispatchQueue.main.async {
            guard !self.callbacks.isEmpty else { return }

            let waiting = self.callbacks
            self.callbacks.removeAll()
            SKPaymentQueue.default().remove(self)

            waiting.forEach { $0(country) }
        }
    }
}
