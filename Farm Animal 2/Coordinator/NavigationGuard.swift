import Foundation
internal import Combine

enum AvailableScreens: Equatable {
    case LOADING
    case MAIN
}

class NavGuard: ObservableObject {
    @Published var currentScreen: AvailableScreens = .LOADING
    static var shared: NavGuard = .init()
}
