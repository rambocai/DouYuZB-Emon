//
//  ZYMainTabBarController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/10.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }

    private func addChildVC(storyName: String) {
        // 1.通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        // 2.将childVc作为子控制器
        addChildViewController(childVC)
    }

}
