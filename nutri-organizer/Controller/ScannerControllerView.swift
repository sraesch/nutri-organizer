//
//  ScannerControllerRep.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 18.01.25.
//

import SwiftUI
import UIKit
import OSLog
import VisionKit
import Vision

@MainActor
struct ScannerControllerView: UIViewControllerRepresentable {
    private var action: (ProductID?) -> Void
    
    init(action: @escaping @MainActor (ProductID?) -> Void) {
        self.action = action
    }
    
    var scannerViewController: DataScannerViewController = DataScannerViewController(
        recognizedDataTypes: [.barcode()],
        qualityLevel: .accurate,
        recognizesMultipleItems: false,
        isHighFrameRateTrackingEnabled: false,
        isHighlightingEnabled: true
    )
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        scannerViewController.delegate = context.coordinator
        
        // Add a button to start scanning
        let scanButton = UIButton(type: .system)
        scanButton.backgroundColor = UIColor.systemBlue
        scanButton.setTitle(String(localized: "stop_scanning"), for: .normal)
        scanButton.setTitleColor(UIColor.white, for: .normal)
        scanButton.addTarget(context.coordinator, action: #selector(Coordinator.stopScanning(_:)), for: .touchUpInside)
        scannerViewController.view.addSubview(scanButton)
        
        // Set up button constraints
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scanButton.centerXAnchor.constraint(equalTo: scannerViewController.view.centerXAnchor),
            scanButton.bottomAnchor.constraint(equalTo: scannerViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        try? scannerViewController.startScanning()
        
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        // Update any view controller settings here
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: ScannerControllerView
        var roundBoxMappings: [UUID: UIView] = [:]
        
        init(_ parent: ScannerControllerView) {
            self.parent = parent
        }
        
        // DataScannerViewControllerDelegate - methods starts here
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            for item in addedItems {
                switch item {
                case .text(let text):
                    Logger.camera.debug("Found text item \(text.transcript)")
                case .barcode(let code):
                    if let payload = code.payloadStringValue {
                        Logger.camera.debug("Barcode payload: \(payload)")
                        Logger.camera.info("Stop Scanning...")
                        parent.scannerViewController.stopScanning()
                        
                        let productCode: ProductID = payload
                        
                        parent.action(productCode)
                    }
                @unknown default:
                    Logger.camera.warning("Should not happen")
                }
            }
        }
        
        // Add this method to stop scanning
        @objc func stopScanning(_ sender: UIButton) {
            Logger.camera.info("Button: Stop Scanning...")
            parent.scannerViewController.stopScanning()
            
            parent.action(nil)
        }
    }
}

/// Internal helper function to check if the given code is a QR code, i.e., 2D code
internal func isQRCode(symbology: VNBarcodeSymbology) -> Bool {
    switch symbology {
    case .qr: return true
    case .aztec: return true
    case .dataMatrix: return true
    case .microQR: return true
    case .pdf417: return true
    case .microPDF417: return true
    default: return false
    }
}
