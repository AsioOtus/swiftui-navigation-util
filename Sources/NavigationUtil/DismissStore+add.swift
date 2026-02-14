import SwiftUI

public extension DismissStore {
	@discardableResult
	func add <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property?>,
		on root: Root,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root, nil, animation: animation)
	}

	@discardableResult
	func add <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property?>,
		on root: Root,
		animation: Animation? = .default,
		_ prepare: @escaping (Property?) async throws -> Void
	) -> DismissStore {
		add(keyPath, on: root, nil, animation: animation, prepare)
	}

	@discardableResult
	func add <Root, Property: DismissPreparable> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property?>,
		on root: Root,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root, nil, animation: animation) {
			try await $0?.prepareDismiss()
		}
	}

	@discardableResult
	func add <Root, Property: AllDismisser> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property?>,
		on root: Root,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root, nil, animation: animation) { property in
			try await property?.dismissAll()
		}
	}
}

// MARK: bool
public extension DismissStore {
	@discardableResult
	func add <Root> (
		_ keyPath: ReferenceWritableKeyPath<Root, Bool>,
		on root: Root,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root, false, animation: animation)
	}

	@discardableResult
	func add <Root> (
		_ keyPath: ReferenceWritableKeyPath<Root, Bool>,
		on root: Root,
		animation: Animation? = .default,
		_ prepare: @escaping () async throws -> Void
	) -> DismissStore {
		add(keyPath, on: root, false, animation: animation) { _ in
			try await prepare()
		}
	}

	@discardableResult
	func add <Root, Property: DismissPreparable> (
		_ keyPath: ReferenceWritableKeyPath<Root, Bool>,
		on root: Root,
		_ property: Property,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root, false, animation: animation) { _ in
			try await property.prepareDismiss()
		}
	}

	@discardableResult
	func add <Root, Property: AllDismisser> (
		_ keyPath: ReferenceWritableKeyPath<Root, Bool>,
		on root: Root,
		_ property: Property,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root, false, animation: animation) { _ in
			try await property.dismissAll()
		}
	}
}

// MARK: value
public extension DismissStore {
	@discardableResult
	func add <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ value: Property,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root) { root, keyPath in
			withAnimation(animation) {
				root[keyPath: keyPath] = value
			}
		}
	}

	@discardableResult
	func add <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ value: Property,
		animation: Animation? = .default,
		_ prepare: @escaping (Property) async throws -> Void
	) -> DismissStore {
		add(keyPath, on: root) { root, keyPath in
			try await prepare(root[keyPath: keyPath])

			withAnimation(animation) {
				root[keyPath: keyPath] = value
			}
		}
	}

	@discardableResult
	func add <Root, Property: DismissPreparable> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ value: Property,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root) { root, keyPath in
			withAnimation(animation) {
				root[keyPath: keyPath] = value
			}
		}
	}

	@discardableResult
	func add <Root, Property: AllDismisser> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ value: Property,
		animation: Animation? = .default
	) -> DismissStore {
		add(keyPath, on: root) { root, keyPath in
			withAnimation(animation) {
				root[keyPath: keyPath] = value
			}
		}
	}
}

// MARK: closure
public extension DismissStore {
	@discardableResult
	func add <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property>
	) -> DismissStore {
		_add(keyPath, root) {
			try await dismiss($0, $1)
		}
	}

	@discardableResult
	func add <Root, Property: DismissPreparable> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property>
	) -> DismissStore {
		_add(keyPath, root) {
			try await $0[keyPath: $1].prepareDismiss()
			try await dismiss($0, $1)
		}
	}

	@discardableResult
	func add <Root, Property: AllDismisser> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property> = { _, _ in }
	) -> DismissStore {
		_add(keyPath, root) {
			try await $0[keyPath: $1].dismissAll()
			try await dismiss($0, $1)
		}
	}
}

// MARK: - private
private extension DismissStore {
	private func _add <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		_ root: Root,
		_ dismiss: @escaping AsyncThrowablePropertyAction<Root, Property>
	) -> DismissStore {
		dismisses.append {
			try await dismiss(root, keyPath)
		}

		return self
	}
}

