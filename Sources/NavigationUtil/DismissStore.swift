import SwiftUI

public final class DismissStore<Root: AnyObject> {
    private var dismissers: [AnyKeyPath: (Root) async throws -> Void] = [:]
    private var forceDismissers: [AnyKeyPath: (Root) -> Void] = [:]

    public init() { }
}

public extension DismissStore {
    @discardableResult
    func dismiss (_ keyPath: AnyKeyPath, in root: Root) async throws -> DismissStore {
        try await dismissers[keyPath]?(root)
        return self
    }

    func dismissAll (in root: Root) async throws {
        for (_, action) in dismissers {
            try await action(root)
        }
    }
}

public extension DismissStore {
    @discardableResult
    func forceDismiss (_ keyPath: AnyKeyPath, in root: Root) async -> DismissStore {
        forceDismissers[keyPath]?(root)
        return self
    }

    func forceDismissAll (in root: Root) {
        for (_, action) in forceDismissers {
            action(root)
        }
    }
}

// MARK: - add

// MARK: optional
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
        _ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property>
    ) -> DismissStore {
        _add(keyPath) {
            try await $0[keyPath: $1].dismissAll()
            try await dismiss($0, $1)
        }
    }
}

// MARK: - add forced

extension DismissStore {
    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>,
        animation: Animation? = .default
    ) -> DismissStore {
        addForced(keyPath, nil, animation: animation)
    }

    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>,
        animation: Animation? = .default,
        _ prepare: @escaping (Property?) -> Void
    ) -> DismissStore {
        addForced(keyPath, nil, animation: animation, prepare)
    }
}

extension DismissStore {
    @discardableResult
    func addForced (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        animation: Animation? = .default
    ) -> DismissStore {
        addForced(keyPath, false, animation: animation)
    }

    @discardableResult
    func addForced (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        animation: Animation? = .default,
        _ prepare: @escaping () -> Void
    ) -> DismissStore {
        addForced(keyPath, false, animation: animation) { _ in
            prepare()
        }
    }
}

extension DismissStore {
    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) -> DismissStore {
        addForced(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ value: Property,
        animation: Animation? = .default,
        _ prepare: @escaping (Property) -> Void
    ) -> DismissStore {
        addForced(keyPath) { root, keyPath in
            prepare(root[keyPath: keyPath])

            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }
}

extension DismissStore {
    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping PropertyAction<Root, Property>
    ) -> DismissStore {
        _addForced(keyPath) {
            dismiss($0, $1)
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

    private func _addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping PropertyAction<Root, Property>
    ) -> DismissStore {
        forceDismissers[keyPath] = { root in
            dismiss(root, keyPath)
        }

        return self
    }
}
