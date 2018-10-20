//
//  ProductInfoCell.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 28/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ProductInfoCell: UITableViewCell {

    @IBOutlet weak var productSpecificationLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
