import SwiftUI

// MARK: - optional
public extension Presenter {
	func present <Property: Presentable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in }
	) async throws {
		try await present(
			keyPath,
			new: new,
			animation: animation,
			adjust: { new in
				if let new {
					adjust(new)
				}
			},
			dismiss: { _, store in
				store.add(keyPath, on: self, animation: .default)
			}
		)
	}

	func present <Property: Presentable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in }
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await present(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: { new in
				if let new {
					adjust(new)
				}
			},
			dismiss: { _, store in
				store.add(keyPath, on: self, animation: .default)
			}
		)
	}
}

// MARK: - general
public extension Presenter {
	func present <Property: Presentable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in }
	) async throws {
		try await present(
			keyPath,
			new: new,
			animation: animation,
			adjust: adjust,
			dismiss: { _, store in
				if let resetValue {
					store.add(keyPath, on: self, resetValue, animation: .default)
				}
			}
		)
	}

	func present <Property: Presentable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		resetValue: Property? = nil,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in }
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await present(
			keyPath,
			new: new,
			requirements: requirements,
			animation: animation,
			adjust: adjust,
			dismiss: { _, store in
				if let resetValue {
					store.add(keyPath, on: self, resetValue, animation: .default)
				}
			}
		)
	}
}

// MARK: - dismiss
public extension Presenter {
	func present <Property: Presentable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		animation: Animation? = .default,
		adjust: (Property?) -> Void = { _ in },
		dismiss: (Property, DismissStore) -> Void
	) async throws {
		try await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: { property, store in
				if let property {
					dismiss(property, store)
				}
			},
			prepare: {
				let property = self[keyPath: keyPath]
				if property?.traits == new.traits {
					adjust(property)
					throw .viewExists
				}

				try await dismissAll()
			},
			adjust: adjust
		)
	}

	func present <Property: Presentable> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in },
		dismiss: (Property, DismissStore) -> Void
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
					throw .viewExists
				}

				try await dismissAll()
			},
			adjust: adjust
		)
	}

	func present <Property: Presentable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property?>,
		new: Property,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: (Property?) -> Void = { _ in },
		dismiss: (Property, DismissStore) -> Void
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: { property, store in
				if let property {
					dismiss(property, store)
				}
			},
			prepare: {
				let property = self[keyPath: keyPath]
				if property?.traits == new.traits, let property {
					adjust(property)
					throw .viewExists
				}

				try await dismissAll()
				try await self.navigationInterceptor.requestPermission(for: requirements)
			},
			adjust: adjust
		)
	}

	func present <Property: Presentable, Requirement: NavigationRequirement> (
		_ keyPath: ReferenceWritableKeyPath<Self, Property>,
		new: Property,
		requirements: [Requirement] = [],
		animation: Animation? = .default,
		adjust: (Property) -> Void = { _ in },
		dismiss: (Property, DismissStore) -> Void
	) async throws where Self: NavigationInterceptable, Self.Requirement == Requirement {
		try await _present(
			keyPath,
			new: new,
			animation: animation,
			dismiss: dismiss,
			prepare: {
				let property = self[keyPath: keyPath]
				if property.traits == new.traits {
					adjust(property)
					throw .viewExists
				}

				try await dismissAll()
				try await self.navigationInterceptor.requestPermission(for: requirements)
			},
			adjust: adjust
		)
	}
}
