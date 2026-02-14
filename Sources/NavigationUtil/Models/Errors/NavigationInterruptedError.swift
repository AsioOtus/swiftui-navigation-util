public struct NavigationInterruptedError: Error {
    public init () { }
}

public extension Error where Self == NavigationInterruptedError {
    static var navigationInterrupted: NavigationInterruptedError { .init() }
}
