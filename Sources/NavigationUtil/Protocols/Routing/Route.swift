public protocol Route {
    associatedtype Requirement: NavigationRequirement

    var requirements: [Requirement] { get }
}

public extension Route {
    var requirements: [Requirement] { [] }
}
