import SwiftUI

public final class DismissStore<Root: AnyObject> {
    internal var dismissers: [AnyKeyPath: (Root) async throws -> Void] = [:]
    internal var forceDismissers: [AnyKeyPath: (Root) -> Void] = [:]

    public init () { }
}

public extension DismissStore {
    func dismiss (_ keyPath: AnyKeyPath, in root: Root) async throws {
        try await dismissers[keyPath]?(root)
    }

    func dismissAll (in root: Root) async throws {
        for (_, action) in dismissers {
            try await action(root)
        }
    }
}

public extension DismissStore {
    func forceDismiss (_ keyPath: AnyKeyPath, in root: Root) async {
        forceDismissers[keyPath]?(root)
    }

    func forceDismissAll (in root: Root) {
        for (_, action) in forceDismissers {
            action(root)
        }
    }
}
