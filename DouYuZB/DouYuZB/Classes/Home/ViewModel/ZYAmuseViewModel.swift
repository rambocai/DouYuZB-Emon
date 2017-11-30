//
//  ZYAmuseViewModel.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYAmuseViewModel: ZYBaseViewModel {
    
}

extension ZYAmuseViewModel {    
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
    
}

