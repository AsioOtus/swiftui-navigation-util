import Foundation

public protocol NavigationConfigurable { }

extension NavigationConfiguration {
    public enum Command {
        case route(VM.Route)
        case configuration(@MainActor (VM) async throws -> Void)
    }
}

public struct NavigationConfiguration <VM>: NavigationConfigurable where VM: AnyObject, VM: Routable {
    let command: Command

    public init (
        _ command: Command
    ) {
        self.command = command
    }

    @MainActor
    public func configure (_ vm: VM) async throws {
        switch command {
        case .route(let route):
            try await vm.navigate(to: route)
        case .configuration(let configuration):
            try await configuration(vm)
        }
    }
}

public extension NavigationConfigurable {
    static func config <VM> (
        of: VM.Type,
        _ configuration: @MainActor @escaping (VM) async throws -> Void
    ) -> NavigationConfiguration<VM> where Self == NavigationConfiguration<VM> {
        .init(.configuration(configuration))
    }

    static func config <VM: Routable> (
        of: VM.Type,
        route: VM.Route
    ) -> NavigationConfiguration<VM> where Self == NavigationConfiguration<VM> {
        .init(.route(route))
    }

    static func wait <VM> (
        on: VM.Type,
        for seconds: Int
    ) -> NavigationConfiguration<VM> where Self == NavigationConfiguration<VM> {
        .init(.configuration { _ in try await Task.sleep(nanoseconds: NSEC_PER_SEC * UInt64(seconds)) })
    }
}
