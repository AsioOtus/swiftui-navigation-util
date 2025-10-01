public final class DismissRegistrar<Root: AnyObject> {
    private var dismissors: [AnyKeyPath: (Root) async throws -> Void] = [:]

    public init() {}

    @discardableResult
    public func register <P> (_ keyPath: ReferenceWritableKeyPath<Root, P?>) -> DismissRegistrar {
        if dismissors.keys.contains(keyPath) { return self }

        dismissors[keyPath] = { root in
            if let value = root[keyPath: keyPath] {
                if let preparable = value as? any DismissPreparable {
                    try await preparable.prepareDismiss()
                } else if let routable = value as? any Routable {
                    try await routable.router.prepareDismiss()
                }
            }

            root[keyPath: keyPath] = nil
        }

        return self
    }

    @discardableResult
    public func register (_ keyPath: ReferenceWritableKeyPath<Root, Bool>) -> DismissRegistrar {
        if dismissors.keys.contains(keyPath) { return self }
        
        dismissors[keyPath] = { root in
            root[keyPath: keyPath] = false
        }

        return self
    }

    public func dismiss (on root: Root) async throws {
        for (_, action) in dismissors {
            try await action(root)
        }
    }
}
