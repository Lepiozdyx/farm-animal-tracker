import SwiftUI
import UIKit
internal import Combine

class OrientationManager: ObservableObject {
    @Published var isHorizontalLock = true
    
    static var shared: OrientationManager = .init()
    
    func lockToPortrait() {
        DispatchQueue.main.async {
            self.isHorizontalLock = true
            self.forceUpdateOrientation()
        }
    }
    
    func unlockAllOrientations() {
        DispatchQueue.main.async {
            self.isHorizontalLock = false
            self.forceUpdateOrientation()
        }
    }
    
    private func forceUpdateOrientation() {
        if #available(iOS 16.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            let orientations: UIInterfaceOrientationMask = isHorizontalLock ? .portrait : .allButUpsideDown
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientations)) { error in
                print("Orientation update error: \(error.localizedDescription)")
            }
            
            for window in windowScene.windows {
                window.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
            }
        } else {
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
}


struct RootView: View {
    @ObservedObject private var nav: NavGuard = NavGuard.shared
    @ObservedObject private var orientationManager: OrientationManager = OrientationManager.shared
    
    var body: some View {
        ZStack {
            switch nav.currentScreen {
            case .LOADING:
                Loading()
            case .MAIN:
                Main()
            }
        }
        .onAppear {
            orientationManager.lockToPortrait()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    nav.currentScreen = .MAIN
                }
            }
        }
    }
}

#Preview {
    RootView()
}
