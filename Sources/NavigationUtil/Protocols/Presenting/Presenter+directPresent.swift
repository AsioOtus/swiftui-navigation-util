import SwiftUI

// - Dismiss
// + Traits check
// - Requirements check

// MARK: - optional
public extension Presenter {
	func directPresent <Property: Presentable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws {
		try await directPresent(
			keyPath,
			new: new,
			animation: animation,
			adjust: { $0.map(adjust) },
			dismiss: { store in
				store.add(keyPath, on: self, nil, animation: .default)
			}
		)
	}
	
	func directPresent <Property: Presentable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws {
		try await directPresent(
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
	
	func directPresent <Property: Presentable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		animation: Animation? = .default,
		adjust: (Property?) -> Void = { _ in },
		dismiss: DismissAction
	) async throws {
		try await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare: {
				let property = self[keyPath: keyPath]
				if property?.traits == new.traits, let property {
					adjust(property)
					throw .viewAlreadyPresented
				}
			},
			adjust: adjust
		)
	}
	
	func directPresent <Property: Presentable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in },
		dismiss: DismissAction
	) async throws {
		try await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare: {
				let property = self[keyPath: keyPath]
				if property.traits == new.traits {
					adjust(property)
					throw .viewAlreadyPresented
				}
			},
			adjust: adjust
		)
	}
}
