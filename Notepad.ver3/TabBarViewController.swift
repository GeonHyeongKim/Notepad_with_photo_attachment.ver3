//
//  TabBarViewController.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/27.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 화면에서 터치가 끝났을 때 호출
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
//        tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true
        
        UIView.animate(withDuration: TimeInterval(0.15)) {
            // alpha 값이 0이면 1로, 1이면 0으로 변경
            // 호출될 때마다 점점 투명해졌다가 점점 진해짐
            tabBar?.alpha = (tabBar?.alpha == 0 ? 1 : 0)
        }
    }
}
