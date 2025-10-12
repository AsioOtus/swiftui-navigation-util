import SwiftUI

public extension Dismisser {
    func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = .default
    ) {
        forceDismiss(keyPath, nil, animation: animation)
    }

    func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = .default,
        _ prepare: @escaping (Property?) -> Void
    ) {
        forceDismiss(keyPath, nil, animation: animation, prepare)
    }
}

public extension Dismisser {
    func forceDismiss (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation? = .default
    ) {
        forceDismiss(keyPath, false, animation: animation)
    }

    func forceDismiss (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation? = .default,
        _ prepare: @escaping () -> Void
    ) async {
        forceDismiss(keyPath, false, animation: animation) { _ in
            prepare()
        }
    }
}

public extension Dismisser {
        func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ value: Property,
        animation: Animation? = .default
    ) {
        forceDismiss(keyPath) { root, keyPath in
            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }

    func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ value: Property,
        animation: Animation? = .default,
        _ prepare: @escaping (Property) -> Void
    ) {
        forceDismiss(keyPath) { root, keyPath in
            prepare(root[keyPath: keyPath])

            withAnimation(animation) {
                root[keyPath: keyPath] = value
            }
        }
    }
}

public extension Dismisser {
        func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ dismiss: @escaping PropertyAction<Self, Property>
    ) {
        dismiss(self, keyPath)
    }
}
