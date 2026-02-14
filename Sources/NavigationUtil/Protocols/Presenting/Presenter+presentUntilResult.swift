import SwiftUI

public extension Presenter where Self: Dismisser {
    func presentUntilResult <Property: ResultProvidable> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws -> Property.ResultValue {
        try await present(
            keyPath,
            new: new,
            animation: animation,
            adjust: adjust
        )

        defer {
            forceDismiss(keyPath, animation: .default)
        }

        if let result = try await self[keyPath: keyPath]?.waitResult() {
            return result
        } else {
            throw .resultProviderIsNil
        }
    }
}
