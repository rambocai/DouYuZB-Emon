//
//  ZYRecommendViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/10.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90
class ZYRecommendViewController: ZYBaseAnchorViewController {

    // MARK:- 懒加载属性
    private lazy var recommendVM: ZYRecommendViewModel = ZYRecommendViewModel()
    private lazy var cycleView: ZYRecommendCycleView = {
        let cycleView = ZYRecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    private lazy var gameView: ZYRecommendGameView = {
        let gameView = ZYRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- 设置UI界面
    override func setupUI() {
        // 1.先调用super.setupUI()
        super.setupUI()
        // 2.将cycleView添加到collectionView中
        collectionView.addSubview(cycleView)
        // 3.将gameView添加collectionView中
        collectionView.addSubview(gameView)
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
    
    // MARK:- 请求数据
    override func loadData() {
        baseVM = recommendVM
        // 1.请求推荐数据
        recommendVM.requestData {
            // 1.1展示推荐数据
            self.collectionView.reloadData()
            
            // 1.2.将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            // 1.2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            // 1.2.2.添加更多组
            let moreGroup = ZYAnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            // 数据请求完成
            self.loadDataFinished()
        }
        // 2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}


// MARK:- UICollectionViewDelegate
extension ZYRecommendViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 获取cell
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! ZYCollectionPrettyCell
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNomalItemW, height: kPrettyItemH)
        } else {
            return CGSize(width: kNomalItemW, height: kNormalItemH)
        }
    }
}

