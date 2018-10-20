//
//  ProductDetailsVC.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 28/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var productInfoContainer: UIView!
    
    //variables and constance
    var timr=Timer()
    var scrollCount = 0
    var productInfo = ProductMapper(dict: [String:Any]())
    let ptoductKeys = ["Barcode","Product Name","Title","Category","Manufacturer","Brand","Ingredients","Nutrition Facts","Color","Package Quantity","Size","Weight","Description","features","Reviews"]
    var productInfoArr = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.addShadow()
            self.productInfoContainer.addShadow()
           // self.configAutoscrollTimer()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let productFeature = productInfo.features.isEmpty ? "" : productInfo.features.count>0 ? productInfo.features.joined(separator:" , ") : productInfo.features[0]
        
        let review = productInfo.reviews.isEmpty ? "" : productInfo.reviews.count>0 ? productInfo.reviews.joined(separator:" , ") : productInfo.reviews[0]
        
        productInfoArr = ["\(productInfo.barcode_type!) : \(productInfo.barcode_number!)",productInfo.product_name!,productInfo.title!,productInfo.category!,productInfo.manufacturer!,productInfo.brand!,productInfo.ingredients!,productInfo.nutrition_facts!,productInfo.color!,productInfo.package_quantity!,productInfo.size!,productInfo.weight!,productInfo.description!,productFeature,review]
         self.tableView.reloadData()
    }
    @IBAction func UpdateInfoToServerDataBase(_ sender: UIButton) {
    }
}
extension ProductDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productInfo.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductImageCell
        cell.productImage.loadImageFor(url: productInfo.images[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:200 )
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        scrollCount = indexPath.item
        configAutoscrollTimer()
        print(indexPath)
    }
}

extension ProductDetailsVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productInfoArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoCell") as! ProductInfoCell
        cell.productSpecificationLabel.text = ptoductKeys[indexPath.item]
        cell.productDescriptionLabel.text =  productInfoArr[indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension ProductDetailsVC
{
    func configAutoscrollTimer()
    {
        guard !productInfo.images.isEmpty else{print("no images to display"); return}
        timr=Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(autoScrollView), userInfo: nil, repeats: true)
    }
    func deconfigAutoscrollTimer()
    {
        timr.invalidate()
        
    }
    func onTimer()
    {
        autoScrollView()
    }
    
    @objc func autoScrollView()
    {
        guard productInfo.images.count==0 else {
            return
        }
        let indexPath = IndexPath(row: scrollCount, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        scrollCount = scrollCount >= productInfo.images.count ? 0 : scrollCount + 1
    }
}
