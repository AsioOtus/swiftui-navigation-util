import SwiftUI

// Force dismiss
// Do not check traits
// Do not check requirements

public extension Presenter {
	func forcePresent (
		_ keyPath: ReferenceWritableKeyPath<Self, Bool>,
		animation: Animation? = .default
	) async throws {
		try await forcePresent(
			keyPath,
			new: true,
			animation: animation,
			adjust: { _ in },
			dismiss: { store in
				store.add(keyPath, on: self, false, animation: .default)
			}
		)
	}

	func forcePresent <Property> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws {
		try await forcePresent(
			keyPath,
			new: new,
			animation: animation,
			adjust: { new in
				if let new {
					adjust(new)
				}
			},
			dismiss: { store in
				store.add(keyPath, on: self, nil, animation: .default)
			}
		)
	}

	func forcePresent <Property> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws {
		try await forcePresent(
			keyPath,
			new: new,
			animation: animation,
			adjust: adjust,
			dismiss: { store in
				if let resetValue {
					store.add(keyPath, on: self, resetValue, animation: .default)
				}
			}
		)
	}

	func forcePresent <Property> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in },
		dismiss: DismissAction
	) async throws {
		await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare: {
				forceDismissAll()
			},
			adjust: adjust
		)
	}
}
