//
//  ZYCollectionNormalCell.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/10.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYCollectionNormalCell: ZYCollectionBaseCell {

    // MARK:- 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    // MARK:- 定义模型属性
    override var anchor: ZYAnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
