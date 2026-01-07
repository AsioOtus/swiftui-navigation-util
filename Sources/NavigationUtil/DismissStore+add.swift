import SwiftUI

public extension DismissStore {
    @discardableResult
    func add <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath, nil, animation: animation)
    }

    @discardableResult
    func add <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>,
        animation: Animation? = .default,
        _ prepare: @escaping (Property?) async throws -> Void
    ) -> DismissStore {
        add(keyPath, nil, animation: animation, prepare)
    }

    @discardableResult
    func add <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath, nil, animation: animation) {
            try await $0?.prepareDismiss()
        }
    }

    @discardableResult
    func add <Property: AllDismisser> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath, nil, animation: animation) { property in
            try await property?.dismissAll()
        }
    }
}

// MARK: bool
public extension DismissStore {
    @discardableResult
    func add (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath, false, animation: animation)
    }

    @discardableResult
    func add (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        animation: Animation? = .default,
        _ prepare: @escaping () async throws -> Void
    ) -> DismissStore {
        add(keyPath, false, animation: animation) { _ in
            try await prepare()
        }
    }

    @discardableResult
    func add <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        _ property: Property,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath, false, animation: animation) { _ in
            try await property.prepareDismiss()
        }
    }

    @discardableResult
    func add <Property: AllDismisser> (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        _ property: Property,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath, false, animation: animation) { _ in
            try await property.dismissAll()
        }
    }
}

// MARK: value
public extension DismissStore {
    @discardableResult
    func add <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    @discardableResult
    func add <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ value: Property,
        animation: Animation? = .default,
        _ prepare: @escaping (Property) async throws -> Void
    ) -> DismissStore {
        add(keyPath) { root, keyPath in
            try await prepare(root[keyPath: keyPath])

            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    @discardableResult
    func add <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    @discardableResult
    func add <Property: AllDismisser> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) -> DismissStore {
        add(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }
}

// MARK: closure
public extension DismissStore {
    @discardableResult
    func add <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property>
    ) -> DismissStore {
        _add(keyPath) {
            try await dismiss($0, $1)
        }
    }

    @discardableResult
    func add <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property>
    ) -> DismissStore {
        _add(keyPath) {
            try await $0[keyPath: $1].prepareDismiss()
            try await dismiss($0, $1)
        }
    }

    @discardableResult
    func add <Property: AllDismisser> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property> = { _, _ in }
    ) -> DismissStore {
        _add(keyPath) {
            try await $0[keyPath: $1].dismissAll()
            try await dismiss($0, $1)
        }
    }
}

// MARK: - private
private extension DismissStore {
    private func _add <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property>
    ) -> DismissStore {
        dismissers[keyPath] = { root in
            try await dismiss(root, keyPath)
        }

        return self
    }
}

