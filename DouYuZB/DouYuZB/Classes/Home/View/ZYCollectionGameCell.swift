//
//  ZYCollectionGameCell.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/11.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit
import Kingfisher

class ZYCollectionGameCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var baseGame : ZYBaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
