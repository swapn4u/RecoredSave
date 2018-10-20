//
//  ProductMapper.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 27/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
struct ProductInfo{
    var productData : [ProductMapper]
    init(dict:[[String:Any]]) {
        self.productData = dict.flatMap{ ProductMapper(dict: $0)}
    }
}
struct ProductMapper
{
    var product_name : String!
    var barcode_number : String!
    var barcode_type : String!
    var barcode_formats : String!
    var mpn : String!
    var model : String!
    var title : String!
    var category : String!
    var manufacturer : String!
    var brand : String!
    var label : String!
    var author : String!
    var publisher : String!
    var artist : String!
    var audience_rating : String!
    var ingredients : String!
    var nutrition_facts : String!
    var color : String!
    var format : String!
    var package_quantity : String!
    var size : String!
    var length : String!
    var width : String!
    var height : String!
    var weight : String!
    var release_date : String!
    var description : String!
    
    var features : [String]!
    var images : [String]!
    var reviews : [String]!
    
    var stores : [productStores]

    init(dict:[String:Any]) {
        self.barcode_number = dict["barcode_number"] as? String ?? ""
        self.product_name = dict["product_name"] as? String ?? ""
        self.barcode_type = dict["barcode_type"] as? String ?? ""
        self.barcode_formats = dict["barcode_formats"] as? String ?? ""
        self.mpn = dict["mpn"] as? String ?? ""
        self.model = dict["model"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.category = dict["category"] as? String ?? ""
        self.manufacturer = dict["manufacturer"] as? String ?? ""
        self.brand = dict["brand"] as? String ?? ""
        self.label = dict["label"] as? String ?? ""
        self.author = dict["author"] as? String ?? ""
        self.publisher = dict["publisher"] as? String ?? ""
        self.artist = dict["artist"] as? String ?? ""
        self.audience_rating = dict["audience_rating"] as? String ?? ""
        self.ingredients = dict["ingredients"] as? String ?? ""
        self.nutrition_facts = dict["nutrition_facts"] as? String ?? ""
        self.color = dict["color"] as? String ?? ""
        self.format = dict["format"] as? String ?? ""
        self.size = dict["size"] as? String ?? ""
        self.package_quantity = dict["package_quantity"] as? String ?? ""
        self.length = dict["length"] as? String ?? ""
        self.width = dict["width"] as? String ?? ""
        self.height = dict["height"] as? String ?? ""
        self.weight = dict["weight"] as? String ?? ""
        self.release_date = dict["release_date"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
        self.features = dict["features"] as? [String] ?? [String]()
        self.images = dict["images"] as? [String] ?? [String]()
        self.reviews = dict["reviews"] as? [String] ?? [String]()
        let stores : [[String:Any]] = dict["stores"] as? [[String:Any]] ?? [[String:Any]]()
        self.stores = stores.flatMap{productStores(dict:$0)}
    }
}
struct productStores
{
    var store_name :  String!
    var store_price : String!
    var product_url : String!
    var currency_code : String
    var currency_symbol : String!
    init(dict:[String:Any]) {
        self.store_name = dict["store_name"] as? String ?? ""
        self.store_price = dict["store_price"] as? String ?? ""
        self.product_url = dict["product_url"] as? String ?? ""
        self.currency_code = dict["currency_code"] as? String ?? ""
        self.currency_symbol = dict["currency_symbol"] as? String ?? ""
    }
}
