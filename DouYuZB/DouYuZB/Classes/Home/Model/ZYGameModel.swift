//
//  ZYGameModel.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYGameModel: ZYBaseGameModel {

    
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //
    }
}
