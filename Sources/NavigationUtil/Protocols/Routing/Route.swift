public protocol Route {
    var requirements: [NavigationRequirement] { get }
}

public extension Route {
    var requirements: [NavigationRequirement] { [] }
}
