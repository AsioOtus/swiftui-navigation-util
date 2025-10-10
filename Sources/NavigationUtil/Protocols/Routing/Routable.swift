public protocol Routable {
    associatedtype Router: NavigationUtil.Router

    var router: Router { get }
}
