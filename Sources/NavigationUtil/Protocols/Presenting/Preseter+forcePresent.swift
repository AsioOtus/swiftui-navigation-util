import SwiftUI

public extension Presenter {
    func forcePresent <Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [Requirement],
        animation: Animation?
    ) async throws {
        try await forcePresent(
            keyPath,
            new: true,
            requirements: requirements,
            animation: animation,
            adjust: { _ in },
            dismiss: {
                $0.add(keyPath, false, animation: .default)
            }
        )
    }

    func forcePresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
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
            dismiss: {
                $0.add(keyPath, nil, animation: .default)
            }
        )
    }

    func forcePresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws {
        try await forcePresent(
            keyPath,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: adjust,
            dismiss: { store in
                if let resetValue {
                    store.add(keyPath, resetValue, animation: .default)
                }
            }
        )
    }

    func forcePresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void,
        dismiss: (DismissStore<Self>) -> Void
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
