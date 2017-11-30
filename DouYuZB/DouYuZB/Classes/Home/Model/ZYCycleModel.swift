//
//  ZYCycleModel.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/11.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYCycleModel: NSObject {

    // 标题
    @objc var title : String = ""
    // 展示的图片地址
    @objc var pic_url : String = ""
    // 主播信息对应的字典
    @objc var room: [String: NSObject]? {
        didSet {
            guard let room = room else { return }
            anchor = ZYAnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor: ZYAnchorModel?
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //
    }
    
}
