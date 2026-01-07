import SwiftUI

public extension DismissStore {
    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>,
        animation: Animation? = .default
    ) -> DismissStore {
        addForced(keyPath, nil, animation: animation)
    }

    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property?>,
        animation: Animation? = .default,
        _ prepare: @escaping (Property?) -> Void
    ) -> DismissStore {
        addForced(keyPath, nil, animation: animation, prepare)
    }
}

public extension DismissStore {
    @discardableResult
    func addForced (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        animation: Animation? = .default
    ) -> DismissStore {
        addForced(keyPath, false, animation: animation)
    }

    @discardableResult
    func addForced (
        _ keyPath: ReferenceWritableKeyPath<Root, Bool>,
        animation: Animation? = .default,
        _ prepare: @escaping () -> Void
    ) -> DismissStore {
        addForced(keyPath, false, animation: animation) { _ in
            prepare()
        }
    }
}

public extension DismissStore {
    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) -> DismissStore {
        addForced(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ value: Property,
        animation: Animation? = .default,
        _ prepare: @escaping (Property) -> Void
    ) -> DismissStore {
        addForced(keyPath) { root, keyPath in
            prepare(root[keyPath: keyPath])

            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }
}

public extension DismissStore {
    @discardableResult
    func addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping PropertyAction<Root, Property>
    ) -> DismissStore {
        _addForced(keyPath) {
            dismiss($0, $1)
        }
    }
}

private extension DismissStore {
    private func _addForced <Property> (
        _ keyPath: ReferenceWritableKeyPath<Root, Property>,
        _ dismiss: @escaping PropertyAction<Root, Property>
    ) -> DismissStore {
        forceDismissers[keyPath] = { root in
            dismiss(root, keyPath)
        }

        return self
    }
}
