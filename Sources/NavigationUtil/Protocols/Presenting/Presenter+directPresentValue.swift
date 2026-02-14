import SwiftUI

// MARK: - bool
public extension Presenter {
	func directPresentValue (
		_ keyPath: ReferenceWritableKeyPath<Self, Bool>,
		animation: Animation? = .default
	) throws {
		try directPresentValue(
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
		adjust: AdjustAction<Property> = { _ in }
	) throws {
		try directPresentValue(
			keyPath,
			new: new,
			animation: animation,
			adjust: { $0.map(adjust) },
			dismiss: { store in
				store.add(keyPath, on: self, nil, animation: .default)
			}
		)
	}

	func directPresentValue <Property: Equatable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) throws {
		try directPresentValue(
			keyPath,
			new: new,
			animation: animation,
			adjust: { $0.map(adjust) },
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
		adjust: AdjustAction<Property> = { _ in }
	) throws {
		try directPresentValue(
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
		adjust: AdjustAction<Property> = { _ in }
	) throws {
		try directPresentValue(
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
		adjust: AdjustAction<Property> = { _ in },
		dismiss: DismissAction
	) throws {
		_present(
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
		adjust: AdjustAction<Property> = { _ in },
		dismiss: DismissAction
	) throws {
		try _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare: {
				let property = self[keyPath: keyPath]
				if property == new {
					adjust(property)
					throw .viewAlreadyPresented
				}
			},
			adjust: adjust
		)
	}
}
