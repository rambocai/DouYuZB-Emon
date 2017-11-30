//
//  ZYPageContentView.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/9.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

protocol ZYPageContentViewDelegate: class {
    func pageContentView(contentView : ZYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class ZYPageContentView: UIView {

    // MARK:- 定义属性
    private var childVCs: [UIViewController]
    private weak var parentViewController: UIViewController?
    private var startOffset: CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate: ZYPageContentViewDelegate?
    // MARK:- 懒加载属性
    private lazy var collectionView: UICollectionView = { [weak self] in
        // 创建Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        // 创建collectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK:- 设置UI界面
extension ZYPageContentView {
    private func setupUI() {
        // 1.将所有子控制器添加到父控制器中
        for childVC in childVCs {
            parentViewController?.addChildViewController(childVC)
        }
        // 2.添加UICollectionView，用于在cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}


// MARK:- UICollectionViewDataSource
extension ZYPageContentView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 设置cell的内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}


// MARK:- UICollectionViewDelegate
extension ZYPageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        // 1.定义获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        // 2.判断左右滑动
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffset {   // 左滑
            // 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            // 如果完全滑过去
            if currentOffsetX - startOffset == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {
            // 计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            // 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            // 计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        //print("progress\(progress) sourceIndex\(sourceIndex) targetIndex\(targetIndex)")
        // 3.将progress、sourceIndex、targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


// MARK:- 对外暴露的方法
extension ZYPageContentView {
    func setCurrentIndex(currentIndex: Int) {
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true
        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}



