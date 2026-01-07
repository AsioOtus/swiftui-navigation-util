import SwiftUI

public extension Presenter {
    func forcePresent <Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default
    ) async throws {
        try await forcePresent(
            keyPath,
            new: true,
            requirements: requirements,
            animation: animation,
            adjust: { _ in },
            dismiss: { _, store in
                store.add(keyPath, false, animation: .default)
            }
        )
    }

    func forcePresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws {
        try await forcePresent(
            keyPath,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: { new in
                if let new {
                    adjust(new)
                }
            },
            dismiss: { _, store in
                store.add(keyPath, nil, animation: .default)
            }
        )
    }

    func forcePresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property? = nil,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws {
        try await forcePresent(
            keyPath,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: adjust,
            dismiss: { _, store in
                if let resetValue {
                    store.add(keyPath, resetValue, animation: .default)
                }
            }
        )
    }

    func forcePresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in },
        dismiss: (Property, DismissStore<Self>) -> Void
    ) async throws {
        try await _present(
            keyPath,
            new: new,
            animation: animation,
            dismiss: dismiss,
            prepare: {
                forceDismissAll()
            },
            adjust: adjust
        )
    }
}
