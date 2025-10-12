public protocol NavigationInterceptor<Requirement>: AllDismisser {
    associatedtype Requirement: NavigationRequirement

    func requestPermission (for requirements: [Requirement]) async throws
    
    func requestPermission (for requirement: Requirement) async throws
}

public extension NavigationInterceptor {
    func requestPermission (for requirements: [Requirement]) async throws {
        for requirement in requirements {
            try await requestPermission(for: requirement)
        }
    }
}
