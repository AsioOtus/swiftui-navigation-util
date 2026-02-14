public protocol AllDismisser: AnyObject {
	var dismissStore: DismissStore { get }

	func dismissAll () async throws
	func forceDismissAll ()
}

public extension AllDismisser {
	func dismissAll () async throws {
		try await dismissStore.dismissAll()
	}

	func forceDismissAll () {
		dismissStore.forceDismissAll()
	}
}

public extension AllDismisser where Self: NavigationInterceptable {
	func dismissAll () async throws {
		try await navigationInterceptor.dismissAll()
		try await dismissStore.dismissAll()
	}

	func forceDismissAll () {
		navigationInterceptor.forceDismissAll()
		dismissStore.forceDismissAll()
	}
}
