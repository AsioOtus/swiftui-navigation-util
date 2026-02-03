public struct ViewExists: Error {
    public init () { }
}

public extension Error where Self == ViewExists {
    static var viewExists: ViewExists { .init() }
}
