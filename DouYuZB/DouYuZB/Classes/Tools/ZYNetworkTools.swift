//
//  ZYNetworkTools.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/10.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class ZYNetworkTools {
    class func requestData(type: MethodType, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping (_ result: Any) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            finishedCallback(result)
        }
        
    }
}
