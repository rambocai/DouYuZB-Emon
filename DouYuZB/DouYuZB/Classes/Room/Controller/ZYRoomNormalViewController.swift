//
//  ZYRoomNormalViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/13.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYRoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        // 依然保持手势
        //navigationController?.interactivePopGestureRecognizer?.delegate = self
        //navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
