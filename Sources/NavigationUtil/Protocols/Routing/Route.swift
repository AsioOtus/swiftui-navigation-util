public protocol Route {
    associatedtype Requirement: NavigationRequirement = EmptyNavigationRequirement

    var requirements: [Requirement] { get }
}

public extension Route {
    var requirements: [Requirement] { [] }
}
