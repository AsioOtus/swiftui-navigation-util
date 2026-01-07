public protocol Presentable: DismissPreparable {
    var traits: Set<AnyHashable> { get }
}

public extension Presentable {
    var traits: Set<AnyHashable> { [] }
}
