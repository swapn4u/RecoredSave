//
//  UIImageview + Extention.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 28/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import SDWebImage
extension UIImageView
{
    func loadImageFor(url:String)
    {
        let imageURL : URL = URL(string: url.replacingOccurrences(of: " ", with: "%20"))!
        self.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "shopping.png"), completed: { (image, error, cacheType, url) -> Void in
            if ((error) != nil) {
                self.image = #imageLiteral(resourceName: "shopping.png")
            } else {
                self.image = image
            }
        })
    }
}
