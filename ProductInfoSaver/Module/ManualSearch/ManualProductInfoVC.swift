//
//  ManualProductInfoVC.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 27/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ManualProductInfoVC: UIViewController {

    @IBOutlet weak var barcodeNoTF: UITextField!
    @IBOutlet weak var productName: UITextField!
    
    var isScanBarcodePerformed = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TROS"
        barcodeNoTF.attributedPlaceholder = NSAttributedString(string: "Enter barcode",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        productName.attributedPlaceholder = NSAttributedString(string: "Enter product name",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    @IBAction func searchProductPressed(_ sender: UIButton)
    {
        self.view.endEditing(true)
        guard !(barcodeNoTF.text?.trimmingCharacters(in:.whitespaces).isEmpty)! || !(productName.text?.trimmingCharacters(in:.whitespaces).isEmpty)! else {
            self.showAlertFor(title: "Invalid Input", message: "Please enter barcode or product name to proceed .", for: self)
            return
            
        }
        self.showLoaderFor(title: "Please wait...")
        let barcodeUrl = !isScanBarcodePerformed ?  "https://api.barcodelookup.com/v2/products?search=\(productName.text!)&formatted=y&key=figa6vkpf89j0r9ukachfe0f30iz9c" : "https://api.barcodelookup.com/v2/products?barcode=\(barcodeNoTF.text!)&formatted=y&key=uttajtgt32no6ywtqm4xnckcu12o4o"
        RequestManger.getProductData(request: barcodeUrl, completed: { (productData) in
            self.dissmissLoader()
            switch productData
            {
            case .success(let productInfo):
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
                switch error {
                case .unknownError( _,_) :
                    print("no data available")
                default:
                    print("unkown error")
                }
            }
        })
    }
    @IBAction func scanBarcodePressed(_ sender: UIButton)
    {
        let barcodeScanVC = self.loadViewController(identifier: "BarcodeScanner") as! BarcodeScanner
        self.navigationController?.pushViewController(barcodeScanVC, animated: true)
    }
    
}
extension ManualProductInfoVC : UITextFieldDelegate
{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        isScanBarcodePerformed = textField.tag == 0
        barcodeNoTF.text = isScanBarcodePerformed ? barcodeNoTF.text : ""
        productName.text = isScanBarcodePerformed ? "" : productName.text
        return true
    }

}
