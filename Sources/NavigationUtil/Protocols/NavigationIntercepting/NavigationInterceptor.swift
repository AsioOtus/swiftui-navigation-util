public protocol NavigationInterceptor<Requirement>: NavigationResetable {
    associatedtype Requirement: NavigationRequirement

    func requestPermission (for requirements: [Requirement]) async throws

    func requestPermission (for requirement: Requirement) async throws
}

public extension NavigationInterceptor {
    func requestPermission (for requirements: [Requirement]) async throws {
        try await requestPermission(for: requirements)
    }
}
