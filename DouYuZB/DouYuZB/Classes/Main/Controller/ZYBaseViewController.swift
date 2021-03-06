//
//  ZYBaseViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/13.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYBaseViewController: UIViewController {

    // MARK: 定义属性
    var contentView: UIView?
    
    // MARK: 懒加载属性
    fileprivate lazy var animImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        // 随着父控件拉伸而拉伸
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        // 1.隐藏内容的View
        contentView?.isHidden = true
        // 2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        // 3.给animImageView执行动画
        animImageView.startAnimating()
    }
    
    func loadDataFinished() {
        // 1.停止动画
        animImageView.stopAnimating()
        // 2.隐藏animImageView
        animImageView.isHidden = true
        // 3.显示内容的View
        contentView?.isHidden = false
    }
    
}






