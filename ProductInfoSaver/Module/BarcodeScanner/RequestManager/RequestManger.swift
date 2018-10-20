//
//  RequestManger.swift
//  ProductInfoSaver
//
//  Created by Swapnil Katkar on 27/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation
class RequestManger: NSObject
{
    class func getProductData(request:String,completed:@escaping((Result<ProductInfo, ServerError>) -> Void))
    {
        let requstUrl = request.replacingOccurrences(of: " ", with: "%20")
        ServerManager.getRequestfor(urlString: requstUrl){ (result) in
            switch result
            {
            case .success(let response):
                
                guard let responseDict = response.dictionaryObject else {
                    print("No Data Error")
                   // completed(.failure(.unknownError(message: NO_DATA_ERROR, statusCode: 000)))
                    return
                }
                guard let productInfo = responseDict["products"] as? [[String:Any]] else {return}
                let productInfoResult  = ProductInfo(dict: productInfo.map({$0}))
                completed(.success(productInfoResult))
                break
                
            case .failure(let error):
                completed(.failure(error))
                break
            }
        }
    }
}

