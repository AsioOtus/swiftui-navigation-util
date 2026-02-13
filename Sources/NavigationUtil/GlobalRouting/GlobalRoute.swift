import Foundation
import SignalUtil
import SwiftUI

public struct GlobalRoute: @unchecked Sendable {
    public let id = UUID()

    public let routes: [any NavigationConfigurable]
    public let precision: Precision

    public init (
        _ routes: [any NavigationConfigurable],
        precision: Precision = .flexible
    ) {
        self.routes = routes
        self.precision = precision
    }

    public func takeFirst <R> (of type: R.Type) -> (R?, Self) {
        switch precision {
        case .absolute: takeFirstAbsolute(type)
        case .flexible: takeFirstFlexible(type)
        }
    }

    private func takeFirstAbsolute <R> (_ type: R.Type) -> (R?, Self) {
        if let typedRoute = routes.first as? R {
            (
                typedRoute,
                .init(
                    .init(routes.dropFirst()),
                    precision: precision
                )
            )
        } else {
            (nil, self)
        }
    }

    private func takeFirstFlexible <NC> (_ type: NC.Type) -> (NC?, Self) {
        if let firstIndex = routes.firstIndex(where: { $0 is NC }){
            if let typedRoute = routes[firstIndex] as? NC {
                return (
                    typedRoute,
                    .init(
                        .init(routes.dropFirst(firstIndex + 1)),
                        precision: precision
                    )
                )
            }
        }

        return (nil, self)
    }
}

extension GlobalRoute: Equatable {
    public static func == (lhs: GlobalRoute, rhs: GlobalRoute) -> Bool {
        lhs.id == rhs.id
    }
}

extension GlobalRoute {
    public enum Precision {
        case absolute
        case flexible
    }
}
