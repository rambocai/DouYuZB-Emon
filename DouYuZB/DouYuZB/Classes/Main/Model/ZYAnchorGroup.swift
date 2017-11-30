//
//  ZYAnchorGroup.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/10.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYAnchorGroup: ZYBaseGameModel {

    // 该组中对应的房间信息
    //@objc var room_list: [[String: NSObject]]?
    @objc var room_list: [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(ZYAnchorModel(dict: dict))
            }
        }
    }
    
    // 组显示的图标
    @objc var icon_name: String = "home_header_normal"
    
    
    // 定义主播模型对应的数组
    lazy var anchors: [ZYAnchorModel] = [ZYAnchorModel]()
    
    
    
    override init() {
        //
    }
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        // 
    }
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String: NSObject]] {
                for dict in dataArray {
                    anchors.append(ZYAnchorModel(dict: dict))
                }
            }
        }
    }
     */
}
