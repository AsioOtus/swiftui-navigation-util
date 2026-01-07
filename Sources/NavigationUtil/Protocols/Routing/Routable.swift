public protocol Routable {
    associatedtype Route: NavigationUtil.Route

    @MainActor
    func navigate (to route: Route) async throws
}
