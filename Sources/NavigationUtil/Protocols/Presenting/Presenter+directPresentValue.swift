import SwiftUI

// MARK: - bool
public extension Presenter {
    func directPresentValue <Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default
    ) async throws {
        try await directPresentValue(
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

    func directPresentValue <Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [Requirement] = [],
        animation: Animation? = .default
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresentValue(
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
}

// MARK: - optional
public extension Presenter {
    func directPresentValue <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws {
        try await directPresentValue(
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

    func directPresentValue <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws {
        try await directPresentValue(
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

    func directPresentValue <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresentValue(
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

    func directPresentValue <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresentValue(
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
}

// MARK: - general
public extension Presenter {
    func directPresentValue <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property? = nil,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws {
        try await directPresentValue(
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

    func directPresentValue <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property? = nil,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws {
        try await directPresentValue(
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

    func directPresentValue <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property? = nil,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresentValue(
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

    func directPresentValue <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property? = nil,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void = { _ in }
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresentValue(
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
}

// MARK: - dismiss
public extension Presenter {
    func directPresentValue <Property, Requirement: NavigationRequirement> (
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
            prepare: { },
            adjust: adjust
        )
    }

    func directPresentValue <Property: Equatable, Requirement: NavigationRequirement> (
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
                let property = self[keyPath: keyPath]
                if property == new {
                    adjust(property)
                    return
                }
            },
            adjust: adjust
        )
    }
}
