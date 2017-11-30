//
//  ZYRecommendGameView.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/11.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class ZYRecommendGameView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 定义数据的属性
    var groups: [ZYBaseGameModel]? {
        didSet {
            // 刷新表格
            collectionView.reloadData()
        }
    }
    
    // MARK:- 快速创建
    class func recommendGameView() -> ZYRecommendGameView {
        return Bundle.main.loadNibNamed("ZYRecommendGameView", owner: nil, options: nil)?.first as! ZYRecommendGameView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = []
        // 注册cell
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "ZYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin)
    }
}


// MARK:- UICollectionViewDataSource
extension ZYRecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 12
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! ZYCollectionGameCell
        //cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.cyan : UIColor.yellow
        let group = groups![indexPath.item]
        cell.baseGame = group
        return cell
    }
}
