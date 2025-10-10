public protocol DismissStorable: AnyObject {
    var dismissSet: DismissSet<Self> { get }
}

public extension DismissStorable {
    var dismissSet: DismissSet<Self> { .init() }
}
