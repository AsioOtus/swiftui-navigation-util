import SwiftUI

internal extension Presenter {
    func _present <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        animation: Animation?,
        dismiss: DismissAction,
        prepare: () async throws -> Void,
        adjust: (Property) -> Void
    ) async rethrows {
        dismiss(dismissStore)

        do {
            try await prepare()
        } catch is ViewExists {
            return
        }

        adjust(new)

        withAnimation(animation) {
            self[keyPath: keyPath] = new
        }
    }
}
