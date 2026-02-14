import SwiftUI

// MARK: - bool
public extension Presenter {
	func directPresentValue (
		_ keyPath: ReferenceWritableKeyPath<Self, Bool>,
		animation: Animation? = .default
	) async throws {
		try await directPresentValue(
			keyPath,
			new: true,
			animation: animation,
			adjust: { _ in },
			dismiss: { store in
				store.add(keyPath, on: self, false, animation: .default)
			}
		)
	}
}

// MARK: - optional
public extension Presenter {
	func directPresentValue <Property> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in }
	) async throws {
		try await directPresentValue(
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

	func directPresentValue <Property: Equatable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in }
	) async throws {
		try await directPresentValue(
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
}

// MARK: - general
public extension Presenter {
	func directPresentValue <Property> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in }
	) async throws {
		try await directPresentValue(
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

	func directPresentValue <Property: Equatable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in }
	) async throws {
		try await directPresentValue(
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
}

// MARK: - dismiss
public extension Presenter {
	func directPresentValue <Property> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in },
		dismiss: DismissAction
	) async throws {
		await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare: { },
			adjust: adjust
		)
	}

	func directPresentValue <Property: Equatable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in },
		dismiss: DismissAction
	) async throws {
		try await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare: {
				let property = self[keyPath: keyPath]
				if property == new {
					adjust(property)
					throw .viewExists
				}
			},
			adjust: adjust
		)
	}
}
