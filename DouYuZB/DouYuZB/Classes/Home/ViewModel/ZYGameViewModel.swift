//
//  ZYGameViewModel.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYGameViewModel {

    // MARK:- 定义属性
    lazy var games:[ZYGameModel] = [ZYGameModel]()
    
}


extension ZYGameViewModel {
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        ZYNetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName": "game"]) { (result) in
            //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            for dict in dataArray {
                self.games.append(ZYGameModel(dict: dict))
            }
            // 完成回调
            finishedCallback()
        }
    }
}
