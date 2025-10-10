public protocol NavigationResetable: Dismisser, DismissStorable {
    func resetNavigation () async throws
}

public extension NavigationResetable {
    func resetNavigation () async throws {
        try await dismissSet.dismiss(on: self)
    }
}

public extension NavigationResetable where Self: NavigationInterceptable {
    func resetNavigation () async throws {
        try await navigationInterceptor.resetNavigation()
        try await dismissSet.dismiss(on: self)
    }
}
