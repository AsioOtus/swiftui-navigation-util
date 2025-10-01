public protocol Presentable: Equatable, DismissPreparable {
    var traits: Set<AnyHashable> { get }
}

public extension Presentable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.traits == rhs.traits
    }
}

public extension Presentable {
    var traits: Set<AnyHashable> { [] }
}

public extension Presentable {
    func prepareDismiss () async throws { }
}

