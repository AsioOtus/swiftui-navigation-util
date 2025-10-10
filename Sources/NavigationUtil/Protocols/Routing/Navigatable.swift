public protocol Navigatable: Presenter {
    associatedtype Route: NavigationUtil.Route

    func navigate (to route: Route) async throws
}
