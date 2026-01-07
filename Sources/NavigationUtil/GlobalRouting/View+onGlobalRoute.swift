import SwiftUI

public extension View {
    func onGlobalRoute <VM> (
        _ vm: VM,
        fileId: String = #fileID,
        line: Int = #line,
    ) -> some View where VM: AnyObject, VM: Routable {
        onSignal(of: GlobalRoute.self, fileId: fileId, line: line) { globalRoute in
            let (navigationConfiguration, globalRoute) = globalRoute.takeFirst(of: NavigationConfiguration<VM>.self)
            
            if let navigationConfiguration {
                try await navigationConfiguration.configure(vm)
                return (.continue, globalRoute)
            } else {
                return (.continue, globalRoute)
            }
        }
    }
}
