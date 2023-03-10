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

        let sellTab = FilterResultViewController.instance(tabBarItemTitle: TabBarItemTitle.sell.rawValue)
        let sellNaVC = UINavigationController(rootViewController: sellTab)
        
        let forRentTab = FilterResultViewController.instance(tabBarItemTitle: TabBarItemTitle.forRent.rawValue)
        let forRentNaVC = UINavigationController(rootViewController: forRentTab)
        
        let projectTab = FilterResultViewController.instance(tabBarItemTitle: TabBarItemTitle.project.rawValue)
        let projectNaVC = UINavigationController(rootViewController: projectTab)
        
        let accountTab =  AccountViewController()
        let accountNaVC = UINavigationController(rootViewController: accountTab)
        
        sellTab.title = TabBarItemTitle.sell.rawValue
        forRentTab.title = TabBarItemTitle.forRent.rawValue
        projectTab.title = TabBarItemTitle.project.rawValue
        accountTab.title = TabBarItemTitle.account.rawValue
        
        sellTab.tabBarItem.image = UIImage(named: ImageName.HOUSE)
        forRentTab.tabBarItem.image = UIImage(named: ImageName.HOUSE)
        projectTab.tabBarItem.image = UIImage(named: ImageName.PROJECT)
        accountTab.tabBarItem.image = UIImage(named: ImageName.USER)
        
        let tabBarItemList = [sellNaVC,forRentNaVC,projectNaVC,accountNaVC]
        
        self.setViewControllers(tabBarItemList, animated: true)
        
        self.tabBar.tintColor = UIColor(named: ColorName.THEMETEXT)
    }
}
