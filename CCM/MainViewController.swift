//
//  MainViewController.swift
//  CCM
//
//  Created by Thanh Tùng Phạm on 18/5/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up a button to present CameraViewController
        let scanButton = UIButton(type: .system)
        scanButton.setTitle("Scan Bill", for: .normal)
        scanButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        scanButton.addTarget(self, action: #selector(presentCameraViewController), for: .touchUpInside)
        view.addSubview(scanButton)
    }
    
    @objc func presentCameraViewController() {
        let cameraViewController = CameraViewController()
        cameraViewController.modalPresentationStyle = .fullScreen
        present(cameraViewController, animated: true, completion: nil)
    }
}
