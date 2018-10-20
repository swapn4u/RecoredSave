//
//  UIViewcontroller + Extention.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 28/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController
{
    func loadViewController(identifier:String) -> UIViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        return controller
    }
    func showAlertFor(title:String , message: String ,for viewController : UIViewController)
    {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertViewController.addAction(OKAction)
        viewController.present(alertViewController, animated: true)
    }
    func showLoaderFor(title:String)
    {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = title
    }
    func dissmissLoader()
    {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
