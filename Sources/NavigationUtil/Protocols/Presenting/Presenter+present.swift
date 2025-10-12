import SwiftUI

// MARK: - bool

public extension Presenter {
    func present <Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [Requirement],
        animation: Animation?
    ) async throws {
        try await present(
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

    func present <Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [Requirement],
        animation: Animation?
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await present(
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
    func present <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws {
        try await present(
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

    func present <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws {
        try await present(
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

    func present <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws {
        try await present(
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

    func present <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await present(
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

    func present <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await present(
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

    func present <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await present(
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
    func present <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws {
        try await present(
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

    func present <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws {
        try await present(
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

    func present <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws {
        try await present(
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

    func present <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await present(
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

    func present <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await present(
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

    func present <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        resetValue: Property?,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await present(
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
    func present <Property, Requirement: NavigationRequirement> (
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
            prepare:  {
                try await dismissAll()
            },
            adjust: adjust
        )
    }

    func present <Property: Equatable, Requirement: NavigationRequirement> (
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
                let property = self[keyPath: keyPath]
                if property == new {
                    adjust(property)
                    return
                }

                try await dismissAll()
            },
            adjust: adjust
        )
    }

    func present <Property: Presentable, Requirement: NavigationRequirement> (
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
                let property = self[keyPath: keyPath]
                if property.traits == new.traits {
                    adjust(property)
                    return
                }

                try await dismissAll()
            },
            adjust: adjust
        )
    }

    func present <Property, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void,
        dismiss: (DismissStore<Self>) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
        try await _present(
            keyPath,
            new: new,
            animation: animation,
            dismiss: dismiss,
            prepare: {
                try await dismissAll()
                try await self.navigationInterceptor.requestPermission(for: requirements)
            },
            adjust: adjust
        )
    }

    func present <Property: Equatable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void,
        dismiss: (DismissStore<Self>) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
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

                try await dismissAll()
                try await self.navigationInterceptor.requestPermission(for: requirements)
            },
            adjust: adjust
        )
    }

    func present <Property: Presentable, Requirement: NavigationRequirement> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        requirements: [Requirement],
        animation: Animation?,
        adjust: (Property) -> Void,
        dismiss: (DismissStore<Self>) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
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

                try await dismissAll()
                try await self.navigationInterceptor.requestPermission(for: requirements)
            },
            adjust: adjust
        )
    }
}
