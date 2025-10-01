public protocol NavigationResetable: Dismisser {
    func resetNavigation () async throws
}
