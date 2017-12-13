//
//  ZYGameViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class ZYGameViewController: ZYBaseViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var gameVM: ZYGameViewModel = ZYGameViewModel()
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ZYCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "ZYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        return collectionView
    }()
    fileprivate lazy var gameView: ZYRecommendGameView = {
        let gameView = ZYRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    fileprivate lazy var topHeaderView: ZYCollectionHeaderView = {
        let topHeaderView = ZYCollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(kGameViewH + kHeaderViewH), width: kScreenW, height: kHeaderViewH)
        topHeaderView.moreBtn.isHidden = true
        topHeaderView.titleLabel.text = "常用"
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        return topHeaderView
    }()
    
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    // MARK:- 设置UI界面
    override func setupUI() {
        // 0.给ContentView进行赋值
        contentView = collectionView
        
        // 1.添加collectionView
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH + kHeaderViewH, left: 0, bottom: 0, right: 0)
        // 2.添加GameView
        collectionView.addSubview(gameView)
        collectionView.addSubview(topHeaderView)
        
        super.setupUI()
    }
}


// MAR:- 请求数据
extension ZYGameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            // 1.展示全部游戏
            self.collectionView.reloadData()
            // 2.展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<6])
            // 3.数据请求完成
            self.loadDataFinished()
        }
    }
}


// MARK:- UICollectionViewDataSource
extension ZYGameViewController: UICollectionViewDataSource {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! ZYCollectionGameCell
        //cell.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
        //cell.backgroundColor = UIColor.randomColor()
        
        cell.baseGame = gameVM.games[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! ZYCollectionHeaderView
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "全部"
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}



