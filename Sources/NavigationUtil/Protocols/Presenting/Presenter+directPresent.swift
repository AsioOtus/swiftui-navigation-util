import SwiftUI

// MARK: - bool

public extension Presenter {
    func directPresent <Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default
    ) async throws {
        try await directPresent(
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

    func directPresent <Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [Requirement] = [],
        animation: Animation? = .default
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresent(
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
}

// MARK: - optional

public extension Presenter {
    func directPresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void
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
            dismiss: {
                $0.add(keyPath, nil, animation: .default)
            }
        )
    }

    func directPresent <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void
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
            dismiss: {
                $0.add(keyPath, nil, animation: .default)
            }
        )
    }

    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void
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
            dismiss: {
                $0.add(keyPath, nil, animation: .default)
            }
        )
    }

    func directPresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void
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
            dismiss: {
                $0.add(keyPath, nil, animation: .default)
            }
        )
    }

    func directPresent <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void
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
            dismiss: {
                $0.add(keyPath, nil, animation: .default)
            }
        )
    }

    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void
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
            dismiss: {
                $0.add(keyPath, nil, animation: .default)
            }
        )
    }
}

// MARK: - general

public extension Presenter {
    func directPresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void
    ) async throws {
        try await directPresent(
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

    func directPresent <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void
    ) async throws {
        try await directPresent(
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

    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void
    ) async throws {
        try await directPresent(
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

    func directPresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresent(
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

    func directPresent <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresent(
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

    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement] = [],
        animation: Animation? = .default,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await directPresent(
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
}

// MARK: - dismiss

public extension Presenter {
    func directPresent <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
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

    func directPresent <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void,
        dismiss: (DismissStore<Self>) -> Void
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

                forceDismissAll()
            },
            adjust: adjust
        )
    }

    func directPresent <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement] = [EmptyNavigationRequirement](),
        animation: Animation? = .default,
        adjust: (Property) -> Void,
        dismiss: (DismissStore<Self>) -> Void
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
                    return
                }

                forceDismissAll()
            },
            adjust: adjust
        )
    }
}
