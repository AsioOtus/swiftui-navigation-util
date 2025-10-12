public protocol AllDismisser: AnyObject {
    var dismissStore: DismissStore<Self> { get }
    
    func dismissAll () async throws
    func forceDismissAll ()
}

public extension AllDismisser {
    func dismissAll () async throws {
        try await dismissStore.dismissAll(in: self)
    }

    func forceDismissAll () {
        dismissStore.forceDismissAll(in: self)
    }
}

public extension AllDismisser where Self: NavigationInterceptable {
    func dismissAll () async throws {
        try await navigationInterceptor.dismissAll()
        try await dismissStore.dismissAll(in: self)
    }

    func forceDismissAll () {
        navigationInterceptor.forceDismissAll()
        dismissStore.forceDismissAll(in: self)
    }
}
