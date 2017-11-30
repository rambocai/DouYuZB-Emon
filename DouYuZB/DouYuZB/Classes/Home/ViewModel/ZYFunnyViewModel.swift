//
//  ZYFunnyViewModel.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/13.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYFunnyViewModel: ZYBaseViewModel {

}

extension ZYFunnyViewModel {
    func loadFunnyFata(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limint": 30, "offset": 0], finishedCallback: finishedCallback)
    }
}






