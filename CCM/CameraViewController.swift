import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the capture session
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            // Handle the error
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            // Handle the error
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        // Add Capture Button
        captureButton = UIButton(type: .system)
        captureButton.setTitle("Capture", for: .normal)
        captureButton.frame = CGRect(x: (view.frame.width - 100) / 2, y: view.frame.height - 100, width: 100, height: 50)
        captureButton.addTarget(self, action: #selector(captureQRCode), for: .touchUpInside)
        view.addSubview(captureButton)
    }
    
    @objc func captureQRCode() {
        captureSession.stopRunning()
        // Further processing is handled in metadataOutput callback
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !metadataObjects.isEmpty else { return }
        
        let qrCodes = metadataObjects.compactMap { $0 as? AVMetadataMachineReadableCodeObject }
        
        let detectedTexts = qrCodes.compactMap { $0.stringValue }
        
        if !detectedTexts.isEmpty {
            DispatchQueue.main.async {
                self.showDetectedTextAlert(detectedTexts: detectedTexts)
            }
        }
    }
    
    func showDetectedTextAlert(detectedTexts: [String]) {
        let message = detectedTexts.joined(separator: "\n")
        let alertController = UIAlertController(title: "Detected QR Codes", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.captureSession.startRunning()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
