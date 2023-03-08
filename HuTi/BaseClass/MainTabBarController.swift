//
//  MainTabBarController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sellTab = FilterResultViewController.instance(tabBarItem: 0)
        let forRentTab = FilterResultViewController.instance(tabBarItem: 1)
        let projectTab = FilterResultViewController.instance(tabBarItem: 2)
        let accountTab = FilterResultViewController.instance(tabBarItem: 4)
        
        sellTab.title = "Bán"
        forRentTab.title = "Cho thuê"
        projectTab.title = "Dự án"
        accountTab.title = "Tài khoản"
        
        self.setViewControllers([sellTab,forRentTab,projectTab,accountTab], animated: true)
    }
}
