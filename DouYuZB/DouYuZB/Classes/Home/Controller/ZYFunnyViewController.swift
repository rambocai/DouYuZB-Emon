//
//  ZYFunnyViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/13.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

private let kTopMargin: CGFloat = 8

class ZYFunnyViewController: ZYBaseAnchorViewController {
    
    // MARK:- 懒加载属性
    lazy var funnyVM: ZYFunnyViewModel = ZYFunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
        // 1.给父类的ViewModel赋值
        baseVM = funnyVM
        // 2.请求数据
        funnyVM.loadFunnyFata {
            // 2.1刷新表格
            self.collectionView.reloadData()
            // 2.2.数据请求完成
            self.loadDataFinished()
        }
    }
}




