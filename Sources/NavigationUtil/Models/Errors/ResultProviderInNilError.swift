public struct ResultProviderInNilError: Error {
    public init () { }
}

public extension Error where Self == ResultProviderInNilError {
    static var resultProviderIsNil: ResultProviderInNilError { .init() }
}
