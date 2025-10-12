import Observation
import SwiftUI

@available(iOS 17.0,*)
@Observable
public final class ResultWaiter <ResultProvider: ResultProvidable>: Presenter, Dismisser {
    public let dismissStore = DismissStore<ResultWaiter>()

    internal let resultProvider: () -> ResultProvider

    public var presenting: ResultProvider?

    public init (_ resultProvider: @escaping @autoclosure () -> ResultProvider) {
        self.resultProvider = resultProvider

        dismissStore.add(\.presenting, animation: .default)
    }

    public func presentUntilResult <Requirement: NavigationRequirement> (
        requirements: [Requirement],
        animation: Animation? = nil,
        adjust: (ResultProvider) -> Void
    ) async throws -> ResultProvider.ResultValue {
        try await presentUntilResult(
            \.presenting,
            new: resultProvider(),
            requirements: requirements,
            animation: animation,
            adjust: adjust
        )
    }
}

@available(iOS 17.0,*)
public extension ResultProvidable {
    func waiter () -> ResultWaiter<Self> {
        .init(self)
    }
}
