//
//  ZYAmuseViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

let kMenuViewH: CGFloat = 200

class ZYAmuseViewController: ZYBaseAnchorViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM = ZYAmuseViewModel()
    fileprivate lazy var menuView: ZYAmuseMenuView = {
        let menuView = ZYAmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- 设置UI界面
    override func setupUI() {
        super.setupUI()
        // 添加菜单的View
        collectionView.addSubview(menuView)
        
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
    
    // MARK:- 请求数据
    override func loadData() {
        // 1.给父类的ViewModel赋值
        baseVM = amuseVM
        // 2.请求数据
        amuseVM.loadAmuseData {
            // 2.1.刷新表格
            self.collectionView.reloadData()
            // 2.2调整数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            // 2.3.数据请求完成
            self.loadDataFinished()
        }
    }
    
}










