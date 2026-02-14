@testable import NavigationUtil

class ParentViewModel: AllDismisser {
	let dismissStore = DismissStore()

	var boolProperty = true
	var optionalValue = String?("a")
	var childVM = ChildViewModel?.some(.init())

	init () {
		dismissStore.add(\.childVM, on: self)
	}
}
