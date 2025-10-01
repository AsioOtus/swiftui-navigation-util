import Observation
import SwiftUI

@available(iOS 17.0,*)
@Observable
public final class ResultWaitingContainer<RP: ResultProvidable>: Presenter {
    public typealias ResultValue = RP.ResultValue

    internal let resultProvider: () -> RP

    public var presented: RP?

    public init (_ resultProvider: @escaping @autoclosure () -> RP) {
        self.resultProvider = resultProvider
    }

    public func presentUntilResult (animation: Animation? = nil,) async throws -> RP.ResultValue {
        try await presentUntilResult(
            \.presented,
             new: resultProvider()
        )
    }

    public func dismiss () async throws {
        forceDismiss(\.presented)
    }
}

@available(iOS 17.0,*)
public extension ResultProvidable {
    func container () -> ResultWaitingContainer<Self> {
        .init(self)
    }
}

@available(iOS 17.0,*)
public extension Presenter {
    func presentUntilResult <P> (
        _ container: ResultWaitingContainer<P>,
        animation: Animation? = nil
    ) async throws -> P.ResultValue where P: Presentable {
        try await container.presentUntilResult(animation: animation)
    }
}

@available(iOS 17.0,*)
public extension Dismisser {
    func dismiss <P> (
        _ container: ResultWaitingContainer<P>,
        animation: Animation? = nil
    ) async throws where P: ResultProvidable {
        try await container.dismiss()
    }
}
