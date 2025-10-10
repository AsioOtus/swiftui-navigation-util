import SwiftUI

public protocol Dismisser {
    func dismiss <Property> (
        _ property: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation?
    ) async throws where Property: DismissPreparable

    func dismiss <Property> (
        _ property: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation?
    ) async throws where Property: Routable

    func dismiss (
        _ property: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation?
    ) async throws

    func forceDismiss <Property> (
        _ property: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation?
    )
}

public extension Dismisser {
    func dismiss <Property> (
        _ property: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = nil
    ) async throws where Property: DismissPreparable {
        try await self[keyPath: property]?.prepareDismiss()

        if let animation {
            withAnimation(animation) {
                self[keyPath: property] = nil
            }
        } else {
            self[keyPath: property] = nil
        }
    }

    func dismiss <Property> (
        _ property: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = nil
    ) async throws where Property: Routable {
        try await self[keyPath: property]?.router.prepareDismiss()

        if let animation {
            withAnimation(animation) {
                self[keyPath: property] = nil
            }
        } else {
            self[keyPath: property] = nil
        }
    }

    func dismiss (
        _ property: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation? = nil
    ) async throws {
        if let animation {
            withAnimation(animation) {
                self[keyPath: property] = false
            }
        } else {
            self[keyPath: property] = false
        }
    }
}

public extension Dismisser {
    func forceDismiss <Property> (
        _ property: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = nil
    ) {
        if let animation {
            withAnimation(animation) {
                self[keyPath: property] = nil
            }
        } else {
            self[keyPath: property] = nil
        }
    }
}
