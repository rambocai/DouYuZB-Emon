//
//  ZYRecommendCycleView.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/11.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class ZYRecommendCycleView: UIView {

    // MARK:- 定义属性
    var cycleTimer: Timer?
    var cycleModels: [ZYCycleModel]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            // 添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:- 快速创建
    class func recommendCycleView() -> ZYRecommendCycleView {
        return Bundle.main.loadNibNamed("ZYRecommendCycleView", owner: nil, options: nil)?.first as! ZYRecommendCycleView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = []
        // 注册cell
        collectionView.register(UINib(nibName: "ZYCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }

}


// MARK:- UICollectionViewDataSource
extension ZYRecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! ZYCollectionCycleCell
        //cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.cyan : UIColor.yellow
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}


// MARK:- UICollectionViewDelegate
extension ZYRecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}


// MARK:- 对定时器的操作方法
extension ZYRecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    private func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        // 1.获取滑动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        // 2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

