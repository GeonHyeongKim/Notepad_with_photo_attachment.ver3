//
//  NewAppDelegate.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/27.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

@UIApplicationMain
class NewAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 1. TabBar Controller를 생성 하고, 배경을 흰색
        let tbC = UITableViewController()
        tbC.view.backgroundColor = UIColor.white
        
        return true
    }
}
