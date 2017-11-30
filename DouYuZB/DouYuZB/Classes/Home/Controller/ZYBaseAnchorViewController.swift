//
//  ZYBaseAnchorViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
let kNomalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNomalItemW * 3 / 4
let kPrettyItemH = kNomalItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kHeaderViewID = "kHeaderViewID"
private let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"

class ZYBaseAnchorViewController: ZYBaseViewController {

    // MARK:- 定义属性
    var baseVM: ZYBaseViewModel!
    lazy var collectionView: UICollectionView = { [unowned self] in
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNomalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 注册Cell
        collectionView.register(UINib(nibName: "ZYCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "ZYCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        // 注册头视图
        collectionView.register(UINib(nibName: "ZYCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
        }()
    
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }

    // MARK:- 设置UI界面
    override func setupUI() {
        // 1.给父类中内容View的引用进行赋值
        contentView = collectionView
        // 2.添加collectionView
        view.addSubview(collectionView)
        // 3.调用super.setupUI()
        super.setupUI()
    }
    
    // MARK:- 请求数据
    func loadData() {
        // 空实现,由子类去实现
    }
    
}


// MARK:- UICollectionViewDataSource
extension ZYBaseAnchorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! ZYCollectionNormalCell
        //cell.backgroundColor = UIColor.randomColor()
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! ZYCollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
}

// MARK:- UICollectionViewDelegate
extension ZYBaseAnchorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("点击\(indexPath)")
        // 1.取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        // 2.判断是秀场房间 & 普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
    }
    
    private func presentShowRoomVc() {
        // 1.创建ShowRoomVc
        let showRoomVc = ZYRoomShowViewController()
        // 2.以Modal方式弹出
        present(showRoomVc, animated: true, completion: nil)
    }
    
    private func pushNormalRoomVc() {
        // 1.创建NormalRoomVc
        let normalRoomVc = ZYRoomNormalViewController()
        // 2.以Push方式弹出
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
    
}

