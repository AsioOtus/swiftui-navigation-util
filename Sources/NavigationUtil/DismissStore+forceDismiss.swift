import SwiftUI

public extension DismissStore {
	@discardableResult
	func addForced <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property?>,
		on root: Root,
		animation: Animation? = .default
	) -> DismissStore {
		addForced(keyPath, on: root, nil, animation: animation)
	}

	@discardableResult
	func addForced <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property?>,
		on root: Root,
		animation: Animation? = .default,
		_ prepare: @escaping (Property?) -> Void
	) -> DismissStore {
		addForced(keyPath, on: root, nil, animation: animation, prepare)
	}
}

public extension DismissStore {
	@discardableResult
	func addForced <Root> (
		_ keyPath: ReferenceWritableKeyPath<Root, Bool>,
		on root: Root,
		animation: Animation? = .default
	) -> DismissStore {
		addForced(keyPath, on: root, false, animation: animation)
	}

	@discardableResult
	func addForced <Root> (
		_ keyPath: ReferenceWritableKeyPath<Root, Bool>,
		on root: Root,
		animation: Animation? = .default,
		_ prepare: @escaping () -> Void
	) -> DismissStore {
		addForced(keyPath, on: root, false, animation: animation) { _ in
			prepare()
		}
	}
}

public extension DismissStore {
	@discardableResult
	func addForced <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ value: Property,
		animation: Animation? = .default
	) -> DismissStore {
		addForced(keyPath, on: root) { root, keyPath in
			withAnimation(animation) {
				root[keyPath: keyPath] = value
			}
		}
	}

	@discardableResult
	func addForced <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ value: Property,
		animation: Animation? = .default,
		_ prepare: @escaping (Property) -> Void
	) -> DismissStore {
		addForced(keyPath, on: root) { root, keyPath in
			prepare(root[keyPath: keyPath])

			withAnimation(animation) {
				root[keyPath: keyPath] = value
			}
		}
	}
}

public extension DismissStore {
	@discardableResult
	func addForced <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		on root: Root,
		_ dismiss: @escaping PropertyAction<Root, Property>
	) -> DismissStore {
		_addForced(keyPath, root) {
			dismiss($0, $1)
		}
	}
}

private extension DismissStore {
	private func _addForced <Root, Property> (
		_ keyPath: ReferenceWritableKeyPath<Root, Property>,
		_ root: Root,
		_ dismiss: @escaping PropertyAction<Root, Property>
	) -> DismissStore {
		forceDismisses.append {
			dismiss(root, keyPath)
		}

		return self
	}
}
