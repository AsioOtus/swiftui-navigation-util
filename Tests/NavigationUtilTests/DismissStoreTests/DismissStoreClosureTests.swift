import Testing

@testable import NavigationUtil

extension DismissStoreTests {
    @Suite("Closure")
    struct DismissStoreClosureTests {
        @Test("Bool")
        func bool () async throws {
            let testVM = ParentViewModel()

            testVM
                .dismissStore
                .add(\.boolProperty) { root, keyPath in
                    root[keyPath: keyPath] = false
                }

            #expect(testVM.boolProperty)

            try await testVM.dismissAll()

            #expect(!testVM.boolProperty)
        }

        @Test("Optional")
        func optional () async throws {
            let testVM = ParentViewModel()

            testVM
                .dismissStore
                    .add(\.optionalValue)
                    .add(\.boolProperty, false)

            #expect(testVM.optionalValue != nil)

            try await testVM.dismissAll()

            #expect(testVM.optionalValue == nil)
        }

        @Test
        func test () async throws {
            let testVM = ParentViewModel()
            testVM.dismissStore.add(\.childVM)

            #expect(testVM.childVM != nil)
            try await testVM.dismissAll()
            #expect(testVM.childVM == nil)
        }
    }
}
