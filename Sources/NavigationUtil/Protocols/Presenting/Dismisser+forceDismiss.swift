import SwiftUI

extension Dismisser {
    func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property?>,
        animation: Animation? = .default,
        _ prepare: @escaping (Property?) -> Void = { _ in }
    ) {
        forceDismiss(keyPath, nil, animation: animation, prepare)
    }

    func forceDismiss (
        _ keyPath: ReferenceWritableKeyPath<Self, Bool>,
        animation: Animation? = .default,
        _ prepare: @escaping () -> Void = { }
    ) async {
        forceDismiss(keyPath, false, animation: animation) { _ in
            prepare()
        }
    }

    func forceDismiss <Property> (
        _ keyPath: ReferenceWritableKeyPath<Self, Property>,
        _ value: Property,
        animation: Animation? = .default,
    _ prepare: @escaping (Property) -> Void = { _ in }
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
