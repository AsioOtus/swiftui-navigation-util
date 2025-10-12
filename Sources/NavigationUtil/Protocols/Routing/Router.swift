public protocol Router: Presenter, Presentable, NavigationInterceptable {
    associatedtype Route: NavigationUtil.Route

    func navigate (to route: Route) async throws
}
