//
//  BarcodeListTableView.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 05/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class BarcodeListCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
