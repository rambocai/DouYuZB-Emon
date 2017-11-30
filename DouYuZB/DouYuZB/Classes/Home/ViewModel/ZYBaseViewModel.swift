//
//  ZYBaseViewModel.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYBaseViewModel {
    
    lazy var anchorGroups: [ZYAnchorGroup] = [ZYAnchorGroup]()
    
}


extension ZYBaseViewModel {
    func loadAnchorData(isGroupData: Bool, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping () -> ()) {
        ZYNetworkTools.requestData(type: .get, URLString: URLString, parameters: parameters) { (result) in
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            // 判断是否是分组数据
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(ZYAnchorGroup(dict: dict))
                }
            } else {
                // 创建组
                let group = ZYAnchorGroup()
                // 遍历dataArray中的字典
                for dict in dataArray {
                    group.anchors.append(ZYAnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            
            // 完成回调
            finishedCallback()
        }
    }
}
