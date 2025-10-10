import SwiftUI

public protocol Presenter: NavigationResetable {
    func present <P, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        requirements: [NR],
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws where P: Presentable

    func present <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws where P: Presentable


    func present <P, NR: NavigationRequirement> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        requirements: [NR],
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws where P: Presentable

    func present <P> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws where P: Presentable


    func present <P, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        requirements: [NR],
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws where P: Equatable

    func present <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws where P: Equatable


    func present <P, NR: NavigationRequirement> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        requirements: [NR],
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws where P: Equatable

    func present <P> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>,
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws where P: Equatable


    func present <NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, Bool>,
        requirements: [NR],
        animation: Animation?,
    ) async throws

    func present (
        _ property: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation?,
    ) async throws
    

    func directPresent <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P
    ) async throws

    func directPresent <P> (
        _ new: P,
        in property: ReferenceWritableKeyPath<Self, P>
    ) async throws

    func directPresent (
        _ property: ReferenceWritableKeyPath<Self, Bool>
    ) async throws

    func presentUntilResult <P, NR: NavigationRequirement> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        requirements: [NR],
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws -> P.ResultValue where P: ResultProvidable

    func presentUntilResult <P> (
        _ property: ReferenceWritableKeyPath<Self, P?>,
        new: P,
        animation: Animation?,
        adjust: (P) -> Void
    ) async throws -> P.ResultValue where P: ResultProvidable
}
