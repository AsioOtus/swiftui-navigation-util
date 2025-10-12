public protocol Router: Presenter, Presentable {
    associatedtype Route: NavigationUtil.Route

    func navigate (to route: Route) async throws
}
