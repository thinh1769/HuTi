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

        let sellTab = FilterResultViewController.instance(mainTabBarItemTitle: MainTitle.sell, tabBarItemTitle: TabBarItemTitle.sell)
        let sellNaVC = UINavigationController(rootViewController: sellTab)
        
        let forRentTab = FilterResultViewController.instance(mainTabBarItemTitle: MainTitle.forRent, tabBarItemTitle: TabBarItemTitle.forRent)
        let forRentNaVC = UINavigationController(rootViewController: forRentTab)
        
        let projectTab = FilterResultViewController.instance(mainTabBarItemTitle: MainTitle.project, tabBarItemTitle: TabBarItemTitle.project)
        let projectNaVC = UINavigationController(rootViewController: projectTab)
        
        let accountTab =  AccountViewController()
        let accountNaVC = UINavigationController(rootViewController: accountTab)
        
        sellTab.title = TabBarItemTitle.sell
        forRentTab.title = TabBarItemTitle.forRent
        projectTab.title = TabBarItemTitle.project
        accountTab.title = TabBarItemTitle.account
        
        sellTab.tabBarItem.image = UIImage(named: ImageName.house)
        forRentTab.tabBarItem.image = UIImage(named: ImageName.house)
        projectTab.tabBarItem.image = UIImage(named: ImageName.project)
        accountTab.tabBarItem.image = UIImage(named: ImageName.user)
        
        let tabBarItemList = [sellNaVC,forRentNaVC,projectNaVC,accountNaVC]
        
        self.setViewControllers(tabBarItemList, animated: true)
        
        self.tabBar.tintColor = UIColor(named: ColorName.themeText)
        
        self.tabBar.backgroundColor = UIColor(named: ColorName.white)
    }
}
