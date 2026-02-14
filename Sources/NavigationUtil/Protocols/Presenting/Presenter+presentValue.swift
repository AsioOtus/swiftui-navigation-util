import SwiftUI

// MARK: - bool
public extension Presenter {
	func presentValue <Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Bool>,
		requirements: [Requirement] = [EmptyNavigationRequirement](),
		animation: Animation? = .default
	) async throws {
		try await presentValue(
			keyPath,
			new: true,
			requirements: requirements,
			animation: animation,
			adjust: { _ in },
			dismiss: { store in
				store.add(keyPath, on: self, animation: .default)
			}
		)
	}

	func presentValue <Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Bool>,
		requirements: [Requirement] = [],
		animation: Animation? = .default
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await presentValue(
			keyPath,
			new: true,
			requirements: requirements,
			animation: animation,
			adjust: { _ in },
			dismiss: { store in
				store.add(keyPath, on: self, animation: .default)
			}
		)
	}
}

// MARK: - optional
public extension Presenter {
	func presentValue <Property, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		requirements: [Requirement] = [EmptyNavigationRequirement](),
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws {
		try await presentValue(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: { $0.map(adjust) },
			dismiss: { store in
				store.add(keyPath, on: self, animation: .default)
			}
		)
	}

	func presentValue <Property: Equatable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		requirements: [Requirement] = [EmptyNavigationRequirement](),
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws {
		try await presentValue(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: { $0.map(adjust) },
			dismiss: { store in
				store.add(keyPath, on: self, animation: .default)
			}
		)
	}

	func presentValue <Property, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await presentValue(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: { $0.map(adjust) },
			dismiss: { store in
				store.add(keyPath, on: self, animation: .default)
			}
		)
	}

	func presentValue <Property: Equatable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await presentValue(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: { $0.map(adjust) },
			dismiss: { store in
				store.add(keyPath, on: self, animation: .default)
			}
		)
	}
}

public extension Presenter {
	func presentValue <Property, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		requirements: [Requirement] = [EmptyNavigationRequirement](),
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws {
		try await presentValue(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: adjust,
			dismiss: { store in
				if let resetValue {
					store.add(keyPath, on: self, resetValue, animation: .default)
				}
			}
		)
	}

	func presentValue <Property: Equatable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		requirements: [Requirement] = [EmptyNavigationRequirement](),
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws {
		try await presentValue(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: adjust,
			dismiss: { store in
				if let resetValue {
					store.add(keyPath, on: self, resetValue, animation: .default)
				}
			}
		)
	}

	func presentValue <Property, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await presentValue(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: adjust,
			dismiss: { store in
				if let resetValue {
					store.add(keyPath, on: self, resetValue, animation: .default)
				}
			}
		)
	}

	func presentValue <Property: Equatable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in }
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await presentValue(
			keyPath,
			new: new,
			requirements: requirements,
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

public extension Presenter {
	func presentValue <Property, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		requirements: [Requirement] = [EmptyNavigationRequirement](),
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in },
		dismiss: DismissAction
	) async throws {
		try await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare:  {
				try await dismissAll()
			},
			adjust: adjust
		)
	}

	func presentValue <Property: Equatable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		requirements: [Requirement] = [EmptyNavigationRequirement](),
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
				if property == new {
					adjust(property)
					throw .viewAlreadyPresented
				}

				try await dismissAll()
			},
			adjust: adjust
		)
	}

	func presentValue <Property, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in },
		dismiss: DismissAction
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare: {
				try await dismissAll()
				try await self.navigationInterceptor.requestPermission(for: requirements)
			},
			adjust: adjust
		)
	}

	func presentValue <Property: Equatable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: AdjustAction<Property> = { _ in },
		dismiss: DismissAction
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await _present(
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

				try await dismissAll()
				try await self.navigationInterceptor.requestPermission(for: requirements)
			},
			adjust: adjust
		)
	}
}
