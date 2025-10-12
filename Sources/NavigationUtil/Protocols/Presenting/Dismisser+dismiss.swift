import SwiftUI

public extension Dismisser {
    func dismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath, nil, animation: animation)
    }

    func dismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = .default,
        _ prepare: @escaping (Property?) -> Void
    ) async throws {
        try await dismiss(keyPath, nil, animation: animation, prepare)
    }

    func dismiss <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath, nil, animation: animation) {
            try await $0?.prepareDismiss()
        }
    }

    func dismiss <Property: AllDismisser> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath, nil, animation: animation) {
            try await $0?.dismissAll()
        }
    }
}

public extension Dismisser {
    func dismiss (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath, false, animation: animation)
    }

    func dismiss (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation? = .default,
        _ prepare: @escaping () async throws -> Void
    ) async throws {
        try await dismiss(keyPath, false, animation: animation) { _ in
            try await prepare()
        }
    }

    func dismiss <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        _ property: Property,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath, false, animation: animation) { _ in
            try await property.prepareDismiss()
        }
    }

    func dismiss <Property: AllDismisser> (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        _ property: Property,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath, false, animation: animation) { _ in
            try await property.dismissAll()
        }
    }
}

public extension Dismisser {
    func dismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    func dismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ value: Property,
        animation: Animation? = .default,
        _ prepare: @escaping (Property) async throws -> Void
    ) async throws {
        try await dismiss(keyPath) { root, keyPath in
            try await prepare(self[keyPath: keyPath])

            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    func dismiss <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    func dismiss <Property: AllDismisser> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) async throws {
        try await dismiss(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }
}

public extension Dismisser {
    func dismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ dismiss: @escaping AsyncThrowablePropertyAction<Self, Property>
    ) async throws {
        try await dismiss(self, keyPath)
    }

    func dismiss <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ dismiss: @escaping AsyncThrowablePropertyAction<Self, Property>
    ) async throws {
        try await self[keyPath: keyPath].prepareDismiss()
        try await dismiss(self, keyPath)
    }

    func dismiss <Property: AllDismisser> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ dismiss: @escaping AsyncThrowablePropertyAction<Self, Property>
    ) async throws {
        try await self[keyPath: keyPath].dismissAll()
        try await dismiss(self, keyPath)
    }
}
