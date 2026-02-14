public struct ViewAlreadyPresentedError: Error {
    public init () { }
}

public extension Error where Self == ViewAlreadyPresentedError {
    static var viewAlreadyPresented: ViewAlreadyPresentedError { .init() }
}
