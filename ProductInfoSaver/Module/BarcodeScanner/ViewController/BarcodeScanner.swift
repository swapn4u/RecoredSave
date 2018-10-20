//
//  ViewController.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 26/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import AVFoundation
class BarcodeScanner: UIViewController
{
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var isTorchOn = false
    @IBOutlet weak var barcodeFocus: UIImageView!
    
    @IBOutlet weak var cameraTorch: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scan Product"
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
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
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417,.qr,.code128,.dataMatrix]
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        view.layer.addSublayer(self.barcodeFocus.layer)
        view.bringSubview(toFront: barcodeFocus)
        view.bringSubview(toFront: cameraTorch)
        captureSession.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (captureSession.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    @IBAction func onOffCameraTorch(_ sender: UIButton)
    {
        sender.setBackgroundImage(!isTorchOn ? #imageLiteral(resourceName: "lightOff") : #imageLiteral(resourceName: "lightOn"), for: .normal)
        isTorchOn = !isTorchOn
    guard let device = AVCaptureDevice.default(for: AVMediaType.video)
            else {return}
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if device.torchMode == .on {
                    device.torchMode = .off
                } else {
                    device.torchMode = .on
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        }
        else {
            print("Torch is not available")
        }
    }

}
extension BarcodeScanner : AVCaptureMetadataOutputObjectsDelegate
{
//    https://api.barcodelookup.com/v2/products?barcode=9780140157376&formatted=y&key=n0gi9edh05a1rmnig1i4ffbv6udkoh
//
//    https://api.barcodelookup.com/v2/products?search=red%20socks&formatted=y&key=n0gi9edh05a1rmnig1i4ffbv6udkoh
//
//    https://api.barcodelookup.com/v2/products?brand=nike&category=shoes&formatted=y&page=2&key=n0gi9edh05a1rmnig1i4ffbv6udkoh
    
    //Still Activated
    //figa6vkpf89j0r9ukachfe0f30iz9c
    
    //Aniket
//    https://api.barcodelookup.com/v2/products?barcode=9780140157376&formatted=y&key=uttajtgt32no6ywtqm4xnckcu12o4o
//
//    https://api.barcodelookup.com/v2/products?search=red%20socks&formatted=y&key=uttajtgt32no6ywtqm4xnckcu12o4o
//
//    https://api.barcodelookup.com/v2/products?brand=nike&category=shoes&formatted=y&page=2&key=uttajtgt32no6ywtqm4xnckcu12o4o
    
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first
        {
            DispatchQueue.main.async {
                
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard (readableObject.stringValue) != nil else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                let alertController = UIAlertController(title: "Barcode Result", message: "Hay your barcode is :\(readableObject.type.rawValue.split(separator: ".").last!) - \(readableObject.stringValue!)", preferredStyle: .alert)
                let ScanNextAction = UIAlertAction(title: "Scan Next", style: .destructive) { (alert) in
                    self.captureSession.startRunning()
                }
                let saveBarcode = UIAlertAction(title: "Store Barcode", style: .default) { (store) in
                    self.captureSession.startRunning()
                    self.showLoaderFor(title: "Please wait...")
                  let barcodeUrl = "https://api.barcodelookup.com/v2/products?barcode=\(readableObject.stringValue!)&formatted=y&key=uttajtgt32no6ywtqm4xnckcu12o4o"
                    RequestManger.getProductData(request: barcodeUrl, completed: { (productData) in
                     self.dissmissLoader()
                        switch productData
                        {
                        case .success(let productInfo):
                            print(productInfo)
                           // self.captureSession.startRunning()
                            if productInfo.productData.count == 1
                            {
                            let productDetails = self.loadViewController(identifier:"ProductDetailsVC" ) as! ProductDetailsVC
                            productDetails.productInfo = productInfo.productData[0]
                            self.navigationController?.pushViewController(productDetails, animated: true)
                            }
                            else
                            {
                                let productList = self.loadViewController(identifier:"ProductListViewController" ) as! ProductListViewController
                                productList.products = productInfo
                                self.navigationController?.pushViewController(productList, animated: true)
                            }
                            
                        case .failure(let error):
                            self.captureSession.startRunning()
                            switch error {
                            case .unknownError( _,_) :
                                print("no data available")
                            default:
                                print("unkown error")
                            }
                        }
                    })
                }
                alertController.addAction(ScanNextAction)
                alertController.addAction(saveBarcode)
                self.present(alertController, animated: true) {
                    
                }
                
            }
        }
    }

}

        
        
