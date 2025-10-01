public protocol DismissRegistrable: AnyObject {
    var dismissRegistrar: DismissRegistrar<Self> { get }
}

public extension DismissRegistrable {
    var dismissRegistrar: DismissRegistrar<Self> { .init() }

    @discardableResult
    func register <P> (_ keyPath: ReferenceWritableKeyPath<Self, P?>) -> Self {
        dismissRegistrar.register(keyPath)
        return self
    }

    @discardableResult
    func register (_ keyPath: ReferenceWritableKeyPath<Self, Bool>) -> Self {
        dismissRegistrar.register(keyPath)
        return self
    }
}

public extension DismissRegistrable where Self: NavigationResetable {
    func resetNavigation () async throws {
        try await dismissRegistrar.dismiss(on: self)
    }
}
