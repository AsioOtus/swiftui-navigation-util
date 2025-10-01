import SwiftUI

public extension Presenter {
    func present <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Presentable {
        try await present(
            property,
            new: new,
            requirements: [EmptyNavigationRequirement](),
            animation: animation,
            adjust: adjust
        )
    }

    func present <P, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Presentable {
        dismissRegistrar.register(property)

        let propertyValue = self[keyPath: property]
        if let propertyValue, propertyValue == new { return }

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: { _ in adjust(new) }
        )
    }

    func present <P, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Presentable, Self: NavigationInterceptable, Self.Requirement == NR {
        dismissRegistrar.register(property)

        let propertyValue = self[keyPath: property]
        if let propertyValue, propertyValue == new { return }

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: { _ in adjust(new) }
        )
    }
}

public extension Presenter {
    func present <P> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Presentable {
        try await present(
            new,
            in: property,
            requirements: [EmptyNavigationRequirement](),
            animation: animation,
            adjust: adjust
        )
    }

    func present <P, NR: NavigationRequirement> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Presentable {
        guard self[keyPath: property] != new else { return }

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: adjust
        )
    }

    func present <P, NR: NavigationRequirement> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Presentable, P: Presentable, Self: NavigationInterceptable, Self.Requirement == NR {
        guard self[keyPath: property] != new else { return }

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: adjust
        )
    }
}

public extension Presenter {
    func present <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Equatable {
        try await present(
            property,
            new: new,
            requirements: [EmptyNavigationRequirement](),
            animation: animation,
            adjust: adjust
        )
    }

    func present <P, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Equatable {
        dismissRegistrar.register(property)

        guard self[keyPath: property] != new else { return }

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: { _ in adjust(new) }
        )
    }

    func present <P, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Equatable, Self: NavigationInterceptable, Self.Requirement == NR {
        dismissRegistrar.register(property)

        guard self[keyPath: property] != new else { return }

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: { _ in adjust(new) }
        )
    }
}

public extension Presenter {
    func present <P> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Equatable {
        try await present(
            new,
            in: property,
            requirements: [EmptyNavigationRequirement](),
            animation: animation,
            adjust: adjust
        )
    }

    func present <P, NR: NavigationRequirement> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Equatable {
        guard self[keyPath: property] != new else { return }

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: adjust
        )
    }

    func present <P, NR: NavigationRequirement> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws where P: Equatable, Self: NavigationInterceptable, Self.Requirement == NR {
        guard self[keyPath: property] != new else { return }

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: adjust
        )
    }
}

public extension Presenter {
    func present (
        _ property: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation? = nil
    ) async throws {
        try await present(
            property,
            requirements: [EmptyNavigationRequirement](),
            animation: animation,
        )
    }

    func present <NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [NR],
        animation: Animation? = nil
    ) async throws {
        dismissRegistrar.register(property)

        guard !self[keyPath: property] else { return }

        try await _present(
            property,
            new: true,
            requirements: requirements,
            animation: animation,
            adjust: { _ in }
        )
    }

    func present <NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [NR],
        animation: Animation? = nil
    ) async throws where Self: NavigationInterceptable, Self.Requirement == NR {
        dismissRegistrar.register(property)

        guard !self[keyPath: property] else { return }

        try await _present(
            property,
            new: true,
            requirements: requirements,
            animation: animation,
            adjust: { _ in }
        )
    }
}

public extension Presenter {
    func directPresent <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P
    ) async throws {
        dismissRegistrar.register(property)
        self[keyPath: property] = new
    }

    func directPresent <P> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>
    ) async throws {
        self[keyPath: property] = new
    }

    func directPresent (
        _ property: ReferenceWritableKeyPath<Self, Bool>
    ) async throws {
        dismissRegistrar.register(property)
        self[keyPath: property] = true
    }
}

public extension Presenter where Self: ForcedNavigationResetable {
    func forcePresent <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P
    ) async throws {
        dismissRegistrar.register(property)
        forcedResetNavigation()
        self[keyPath: property] = new
    }

    func forcePresent <P> (
        _ property: ReferenceWritableKeyPath<Self, P>,
        new: P
    ) async throws {
        forcedResetNavigation()
        self[keyPath: property] = new
    }

    func forcePresent (
        _ property: ReferenceWritableKeyPath<Self, Bool>
    ) async throws {
        dismissRegistrar.register(property)
        forcedResetNavigation()
        self[keyPath: property] = true
    }
}

public extension Presenter {
    func presentUntilResult <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws -> P.ResultValue where P: ResultProvidable {
        try await presentUntilResult(
            property,
            new: new,
            requirements: [EmptyNavigationRequirement](),
            adjust: adjust
        )
    }

    func presentUntilResult <P, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        requirements: [NR],
        animation: Animation? = nil,
        adjust: (P) -> Void = { _ in }
    ) async throws -> P.ResultValue where P: ResultProvidable {
        dismissRegistrar.register(property)

        try await _present(
            property,
            new: new,
            requirements: requirements,
            animation: animation,
            adjust: { _ in adjust(new) }
        )

        defer {
            forceDismiss(property, animation: animation)
        }

        if let result = try await self[keyPath: property]?.waitResult() {
            return result
        } else {
            throw NavigationInterruptedError()
        }
    }
}

private extension Presenter {
    func _present <T, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, T>,
        new: T,
        requirements: [NR],
        animation: Animation?,
        adjust: (T) -> Void
    ) async throws {
        try await resetNavigation()

        adjust(new)

        if let animation {
            withAnimation(animation) {
                self[keyPath: property] = new
            }
        } else {
            self[keyPath: property] = new
        }
    }

    func _present <T, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, T>,
        new: T,
        requirements: [NR],
        animation: Animation?,
        adjust: (T) -> Void
    ) async throws where Self: NavigationInterceptable, Self.Requirement == NR {
        try await resetNavigation()

        try await self.requestPermission(for: requirements)

        adjust(new)

        if let animation {
            withAnimation(animation) {
                self[keyPath: property] = new
            }
        } else {
            self[keyPath: property] = new
        }
    }
}
