import SwiftUI

extension Dismisser {
        func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation?
    ) {
        forceDismiss(keyPath, nil, animation: animation)
    }

        func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation?,
        _ prepare: @escaping (Property?) -> Void
    ) {
        forceDismiss(keyPath, nil, animation: animation, prepare)
    }
}

extension Dismisser {
        func forceDismiss (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation?
    ) {
        forceDismiss(keyPath, false, animation: animation)
    }

        func forceDismiss (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation?,
        _ prepare: @escaping () -> Void
    ) async {
        forceDismiss(keyPath, false, animation: animation) { _ in
            prepare()
        }
    }
}

extension Dismisser {
        func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ value: Property,
        animation: Animation?
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
        animation: Animation?,
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

extension Dismisser {
        func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ dismiss: @escaping PropertyAction<Self, Property>
    ) {
        dismiss(self, keyPath)
    }
}
