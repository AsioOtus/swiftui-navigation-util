import SwiftUI

// MARK: - optional
public extension Presenter {
    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws {
        try await directPresent(
            keyPath,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: { new in
                if let new {
                    adjust(new)
                }
            },
            dismiss: { store in
                store.add(keyPath, on: self, nil, animation: .default)
            }
        )
    }

    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresent(
            keyPath,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: { new in
                if let new {
                    adjust(new)
                }
            },
            dismiss: { store in
                store.add(keyPath, on: self, nil, animation: .default)
            }
        )
    }
}

// MARK: - general
public extension Presenter {
    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property? = nil,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws {
        try await directPresent(
            keyPath,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: adjust,
            dismiss: { store in
                if let resetValue {
                    store.add(keyPath, on: self, resetValue, animation: .default)
                }
            }
        )
    }

    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property? = nil,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresent(
            keyPath,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: adjust,
            dismiss: { store in
                if let resetValue {
                    store.add(keyPath, on: self, resetValue, animation: .default)
                }
            }
        )
    }
}

// MARK: - dismiss
public extension Presenter {
    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property?) -> Void = { _ in },
        dismiss: DismissAction
    ) async throws {
        try await _present(
            keyPath,
            new: new,
            animation: animation,
            dismiss: dismiss,
            prepare: {
                let property = self[keyPath: keyPath]
                if property?.traits == new.traits, let property {
                    adjust(property)
                    throw .viewExists
                }
            },
            adjust: adjust
        )
    }

    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in },
        dismiss: DismissAction
    ) async throws {
        try await _present(
            keyPath,
            new: new,
            animation: animation,
            dismiss: dismiss,
            prepare: {
                let property = self[keyPath: keyPath]
                if property.traits == new.traits {
                    adjust(property)
                    throw .viewExists
                }
            },
            adjust: adjust
        )
    }
}
