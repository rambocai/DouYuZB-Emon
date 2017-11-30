//
//  ZYRoomShowViewController.swift
//  DouYuZB
//
//  Created by 竹雨 on 2017/10/13.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ZYRoomShowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyan
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}



