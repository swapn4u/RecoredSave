//
//  ProductListViewController.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 05/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var products = ProductInfo(dict: [[String:Any]]())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
extension ProductListViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarcodeListCell") as! BarcodeListCell
        if !products.productData[indexPath.row].images.isEmpty{
            cell.productImage.loadImageFor(url: products.productData[indexPath.row].images[0])
        }
        else
        {
             cell.productImage.image = #imageLiteral(resourceName: "shopping.png")
        }
        cell.productName.text = products.productData[indexPath.row].product_name
        cell.productDescription.text = products.productData[indexPath.row].brand
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetails = self.loadViewController(identifier:"ProductDetailsVC" ) as! ProductDetailsVC
        productDetails.productInfo = products.productData[indexPath.row]
        self.navigationController?.pushViewController(productDetails, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
