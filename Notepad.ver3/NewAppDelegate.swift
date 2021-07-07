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
        let tbC = UITabBarController()
        tbC.view.backgroundColor = UIColor.white
        
        // 2. 생성된 tbC를 루트 뷰 컨트롤로 등록
        self.window?.rootViewController = tbC
        
        // 3. 각 탭 바 아이템에 연결될 뷰 컨트롤러 객체를 생성
        let view01 = FirstViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        // 4. 생성된 뷰 컨트롤러 객체들을 탭 바 컨트롤러에 등록
        tbC.setViewControllers([view01, view02, view03], animated: false)
        
        // 5. 개별 탭 바 아이템의 속성을 설정
        view01.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "calandar"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "File", image: UIImage(named: "file-three"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "Photo", image: UIImage(named: "photo"), selectedImage: nil)

        return true
    }
}
