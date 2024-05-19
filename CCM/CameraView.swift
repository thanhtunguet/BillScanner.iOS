import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    
    class Coordinator: NSObject {
        var parent: CameraView
        
        init(parent: CameraView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraViewController = CameraViewController()
        return cameraViewController
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // No need to update UI
    }
}
