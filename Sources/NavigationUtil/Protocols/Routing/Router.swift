public protocol Router: Presenter {
    associatedtype Route: NavigationUtil.Route

    func navigate (to route: Route) async throws
}
