public final class DismissSet<Root: AnyObject> {
    private var dismissors: [AnyKeyPath: (Root) async throws -> Void] = [:]

    public init() {}

    // MARK: - Optionals

    @discardableResult
    public func add <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>
    ) -> DismissSet {
        guard !dismissors.keys.contains(keyPath) else { return self }

        dismissors[keyPath] = { root in
            if let property = root[keyPath: keyPath] {
                try await property.prepareDismiss()
                root[keyPath: keyPath] = nil
            }
        }

        return self
    }

    @discardableResult
    public func add <Property: Routable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>
    ) -> DismissSet {
        guard !dismissors.keys.contains(keyPath) else { return self }

        dismissors[keyPath] = { root in
            if let property = root[keyPath: keyPath] {
                try await property.router.prepareDismiss()
                root[keyPath: keyPath] = nil
            }
        }

        return self
    }

    @discardableResult
    public func add <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>
    ) -> DismissSet {
        guard !dismissors.keys.contains(keyPath) else { return self }

        dismissors[keyPath] = { root in
            root[keyPath: keyPath] = nil
        }

        return self
    }

    // MARK: - Non-optionals

    @discardableResult
    public func add <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>
    ) -> DismissSet {
        guard !dismissors.keys.contains(keyPath) else { return self }

        dismissors[keyPath] = { root in
            try await root[keyPath: keyPath].prepareDismiss()
        }

        return self
    }

    @discardableResult
    public func add <Property: Routable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>
    ) -> DismissSet {
        guard !dismissors.keys.contains(keyPath) else { return self }

        dismissors[keyPath] = { root in
            try await root[keyPath: keyPath].router.prepareDismiss()
        }

        return self
    }

    @discardableResult
    public func add <Property: NavigationResetable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>
    ) -> DismissSet {
        guard !dismissors.keys.contains(keyPath) else { return self }

        dismissors[keyPath] = { root in
            try await root[keyPath: keyPath].resetNavigation()
        }

        return self
    }

    // MARK: - Bool variants

    @discardableResult
    public func add (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>
    ) -> DismissSet {
        guard !dismissors.keys.contains(keyPath) else { return self }

        dismissors[keyPath] = { root in
            root[keyPath: keyPath] = false
        }

        return self
    }

    @discardableResult
    public func add <Property: DismissPreparable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        _ property: Property
    ) -> DismissSet {
        dismissors[keyPath] = { root in
            try await property.prepareDismiss()
            root[keyPath: keyPath] = false
        }

        return self
    }

    @discardableResult
    public func add <Property: Routable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        _ property: Property
    ) -> DismissSet {
        dismissors[keyPath] = { root in
            try await property.router.prepareDismiss()
            root[keyPath: keyPath] = false
        }

        return self
    }

    // MARK: - 
    @discardableResult
    public func add <Property: Routable> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping (Root, ReferenceWritableKeyPath<Root, Property>) -> Void
    ) -> DismissSet {
        dismissors[keyPath] = { root in
            dismiss(root, keyPath)
        }

        return self
    }

    // MARK: - Execute dismiss

    public func dismiss (on root: Root) async throws {
        for (_, action) in dismissors {
            try await action(root)
        }
    }
}
