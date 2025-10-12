public typealias AsyncThrowablePropertyAction <Root, Property> = (Root, ReferenceWritableKeyPath<Root, Property>) async throws -> Void

public typealias AsyncPropertyAction <Root, Property> = (Root, ReferenceWritableKeyPath<Root, Property>) async -> Void

public typealias ThrowablePropertyAction <Root, Property> = (Root, ReferenceWritableKeyPath<Root, Property>) throws -> Void

public typealias PropertyAction <Root, Property> = (Root, ReferenceWritableKeyPath<Root, Property>) -> Void
