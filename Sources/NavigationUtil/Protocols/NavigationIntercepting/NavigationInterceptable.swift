public protocol NavigationInterceptable<Interceptor> {
    associatedtype Requirement: NavigationRequirement
    associatedtype Interceptor: NavigationInterceptor where Interceptor.Requirement == Requirement

    var navigationInterceptor: Interceptor { get }
}

public extension NavigationInterceptable {
    func requestPermission (for requirements: [Interceptor.Requirement]) async throws {
        try await navigationInterceptor.requestPermission(for: requirements)
    }

    func requestPermission (for requirement: Interceptor.Requirement) async throws {
        try await navigationInterceptor.requestPermission(for: requirement)
    }
}
