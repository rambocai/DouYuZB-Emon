//
//  ZYRecommendViewModel.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/10.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYRecommendViewModel: ZYBaseViewModel {
    // MARK:- 懒加载属性
    // 颜值部分
    private lazy var prettyGroup: ZYAnchorGroup = ZYAnchorGroup()
    // 热门部分
    private lazy var bigDataGroup: ZYAnchorGroup = ZYAnchorGroup()
    
    // 轮播图部分
    lazy var cycleModels: [ZYCycleModel] = [ZYCycleModel]()
}

// MARK:- 发送网络请求
extension ZYRecommendViewModel {
    // 请求推荐数据
    func requestData(finishCallback: @escaping () -> ()) {
        // 1.定义参数
        let parameters = ["limit": "4", "offset": "0", "time": Date.getCurrentTime()]
        //print(NSDate.getCurrentTime())
        
        // 2.创建Group
        let dGroup = DispatchGroup()
        
        // 3.请求推荐数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1507647883
        ZYNetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            
            guard let resultDict = result as? [String: NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            // 字典 -> 模型
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchor = ZYAnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            // 离开组
            dGroup.leave()
        }
        
        // 4.请求颜值数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1507647883
        ZYNetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String: NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            // 字典 -> 模型
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray {
                let anchor = ZYAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            // 离开组
            dGroup.leave()
        }
        
        // 5.请求游戏数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1507647883
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            // 离开组
            dGroup.leave()
        }
        
        
        // 6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    // 请求轮播图数据
    func requestCycleData(finishCallback: @escaping () -> ()) {
        ZYNetworkTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            guard let resultDict = result as? [String: NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            // 字典 -> 模型
            for dict in dataArray {
                self.cycleModels.append(ZYCycleModel(dict: dict))
            }
            finishCallback()
        }
    }
}




