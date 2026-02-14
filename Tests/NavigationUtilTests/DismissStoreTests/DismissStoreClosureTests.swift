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
								.add(\.boolProperty, on: testVM) { root, keyPath in
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
                    .add(\.optionalValue, on: testVM)
                    .add(\.boolProperty, on: testVM, false)

            #expect(testVM.optionalValue != nil)

            try await testVM.dismissAll()

            #expect(testVM.optionalValue == nil)
        }

        @Test
        func test () async throws {
            let testVM = ParentViewModel()
            testVM.dismissStore.add(\.childVM, on: testVM)

            #expect(testVM.childVM != nil)
            try await testVM.dismissAll()
            #expect(testVM.childVM == nil)
        }
    }
}
