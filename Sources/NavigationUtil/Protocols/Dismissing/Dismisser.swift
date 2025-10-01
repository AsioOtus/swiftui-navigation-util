import SwiftUI

public protocol Dismisser: DismissRegistrable {
    func dismiss <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        animation: Animation?
    ) async throws where P: DismissPreparable

    func dismiss <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        animation: Animation?
    ) async throws where P: Routable

    func dismiss (
        _ property: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation?
    ) async throws

    func forceDismiss <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        animation: Animation?
    )
}

public extension Dismisser {
    func dismiss <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        animation: Animation? = nil
    ) async throws where P: DismissPreparable {
        try await self[keyPath: property]?.prepareDismiss()

        if let animation {
            withAnimation(animation) {
                self[keyPath: property] = nil
            }
        } else {
            self[keyPath: property] = nil
        }
    }

    func dismiss <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        animation: Animation? = nil
    ) async throws where P: Routable {
        try await self[keyPath: property]?.router.prepareDismiss()

        if let animation {
            withAnimation(animation) {
                self[keyPath: property] = nil
            }
        } else {
            self[keyPath: property] = nil
        }
    }

    func dismiss <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        animation: Animation? = nil
    ) async throws where P: Equatable {
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
    func forceDismiss <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
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
