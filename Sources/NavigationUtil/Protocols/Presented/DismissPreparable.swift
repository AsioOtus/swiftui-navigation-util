public protocol DismissPreparable {
    func prepareDismiss () async throws
}

public extension DismissPreparable {
    func prepareDismiss () async throws { }
}

public extension DismissPreparable where Self: AllDismisser {
    func prepareDismiss () async throws {
        try await dismissAll()
    }
}
