public protocol Routable: Presentable {
    associatedtype R: Router

    var router: R { get }
}
