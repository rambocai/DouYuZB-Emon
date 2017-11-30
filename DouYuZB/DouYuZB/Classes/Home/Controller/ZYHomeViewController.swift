//
//  ZYHomeViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/9.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40
class ZYHomeViewController: UIViewController {

    // MARK:- 懒加载属性
    private lazy var pageTitleView: ZYPageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = ZYPageTitleView(frame: titleFrame, titles: titles)
        //titleView.backgroundColor = UIColor.cyan
        titleView.delegate = self
        return titleView
    }()
    private lazy var pageContentView: ZYPageContentView = { [weak self] in
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        // 2.确定所有的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(ZYRecommendViewController())
        childVCs.append(ZYGameViewController())
        childVCs.append(ZYAmuseViewController())
        childVCs.append(ZYFunnyViewController())
        
        let contentView = ZYPageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}


// MARK:- 设置UI界面
extension ZYHomeViewController {
    private func setupUI()  {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        // 1.设置导航栏
        setupNavigationBar()
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        // 3.添加ContentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
}


// MARK:- ZYPageTitleDelegate
extension ZYHomeViewController: ZYPageTitleViewDelegate {
    func pageTitleView(titleView: ZYPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}


// MARK:- ZYPageContentViewDelegate
extension ZYHomeViewController: ZYPageContentViewDelegate {
    func pageContentView(contentView: ZYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
