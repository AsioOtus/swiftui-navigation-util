import SwiftUI

internal extension Presenter {
	func _present <Property> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		animation: Animation?,
		dismiss: DismissAction,
		prepare: () async throws -> Void,
		adjust: AdjustAction<Property>
	) async rethrows {
		dismiss(dismissStore)

		do {
			try await prepare()
		} catch is ViewAlreadyPresentedError {
			return
		}

		adjust(new)

		withAnimation(animation) {
			self[keyPath: keyPath] = new
		}
	}

	func _present <Property> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		animation: Animation?,
		dismiss: DismissAction,
		prepare: () throws -> Void,
		adjust: AdjustAction<Property>
	) rethrows {
		dismiss(dismissStore)

		do {
			try prepare()
		} catch is ViewAlreadyPresentedError {
			return
		}

		adjust(new)

		withAnimation(animation) {
			self[keyPath: keyPath] = new
		}
	}
}
