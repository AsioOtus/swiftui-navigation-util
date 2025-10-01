public protocol Router: Presenter, DismissPreparable, NavigationInterceptable { }

public extension Router {
    func prepareDismiss () async throws { }
}
