//
//  ZYAmuseMenuView.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class ZYAmuseMenuView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:- 定义属性
    var groups: [ZYAnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    class func amuseMenuView() -> ZYAmuseMenuView {
        return Bundle.main.loadNibNamed("ZYAmuseMenuView", owner: nil, options: nil)?.first as! ZYAmuseMenuView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = []
        
        collectionView.register(UINib(nibName: "ZYAmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
        
        //print(collectionView.bounds)
        
    }
    
    
}

extension ZYAmuseMenuView {
    override func layoutSubviews() {
        super.layoutSubviews()
        //print(collectionView.bounds)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}


extension ZYAmuseMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! ZYAmuseMenuViewCell
        //cell.backgroundColor = UIColor.randomColor()
        // 设置cell的数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell: ZYAmuseMenuViewCell, indexPath: IndexPath) {
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15   ...
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        // 2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        // 3.取出数据赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
    
}


// MARK:- UICollectionViewDelegate
extension ZYAmuseMenuView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
}
