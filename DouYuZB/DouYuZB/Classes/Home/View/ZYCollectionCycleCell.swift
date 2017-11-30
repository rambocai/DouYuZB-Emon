//
//  ZYCollectionCycleCell.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/11.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit
import Kingfisher
class ZYCollectionCycleCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var cycleModel: ZYCycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            if let iconURL = URL(string: cycleModel?.pic_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "Img_default")
            }
            
        }
    }
    
    
    
    
}
