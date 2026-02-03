import SwiftUI

internal extension Presenter {
    func _present <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        animation: Animation?,
        dismiss: (Property, DismissStore<Self>) -> Void,
        prepare: () async throws -> Void,
        adjust: (Property) -> Void
    ) async rethrows {
        dismiss(new, dismissStore)

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
