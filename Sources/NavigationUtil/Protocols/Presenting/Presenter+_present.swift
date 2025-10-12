import SwiftUI

internal extension Presenter {
    func _present <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        new: Property,
        animation: Animation?,
        dismiss: (DismissStore<Self>) -> Void,
        prepare: () async throws -> Void,
        adjust: (Property) -> Void
    ) async throws {
        dismiss(dismissStore)
        try await prepare()
        adjust(new)

        withAnimation(animation) {
            self[keyPath: keyPath] = new
        }
    }
}
