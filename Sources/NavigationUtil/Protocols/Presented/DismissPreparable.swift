public protocol DismissPreparable {
    func prepareDismiss () async throws
}

public extension DismissPreparable where Self: NavigationResetable {
    func prepareDismiss () async throws {
        try await resetNavigation()
    }
}
