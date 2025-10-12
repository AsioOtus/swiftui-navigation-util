@testable import NavigationUtil

final class ParentViewModel: AllDismisser {
    let dismissStore = DismissStore<ParentViewModel>()

    var boolProperty = true
    var optionalValue = String?("a")

    var childVM = ChildViewModel?.some(.init())
}
