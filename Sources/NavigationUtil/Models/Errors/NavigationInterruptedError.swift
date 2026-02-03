public struct NavigationInterruptedError: Error {
    public init () { }
}

public extension Error where Self == NavigationInterruptedError {
    static var navigationInterrupting: NavigationInterruptedError { .init() }
}
