import SwiftUI

public extension Presenter where Self: Dismisser {
    func presentUntilResult <Property: ResultProvidable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement],
        animation: Animation? = .default,
        adjust: (Property) -> Void
    ) async throws -> Property.ResultValue {
        try await present(
            keyPath,
            new: new,
            requirements: requirements,
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
