public class DismissStore {
	internal var dismisses: [() async throws -> Void] = []
	internal var forceDismisses: [() -> Void] = []

	public init () { }
}

public extension DismissStore {
	func dismissAll () async throws {
		for dismiss in dismisses {
			try await dismiss()
		}
	}

	func forceDismissAll () {
		for dismiss in forceDismisses {
			dismiss()
		}
	}
}
