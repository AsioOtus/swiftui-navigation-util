public protocol Router: Navigatable, NavigationInterceptable, Presentable { }

public extension Router {
    func prepareDismiss () async throws {
        try await resetNavigation()
    }
}
