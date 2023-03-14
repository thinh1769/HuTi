//
//  AccountViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 09/03/2023.
//

import UIKit

class AccountViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - SetupUI.
extension AccountViewController {
    private func setupUI() {
        isHiddenNavigationBar = true
    }
}

// MARK: - @IBAction.
extension AccountViewController {
    @IBAction func onClickedNewPostBtn(_ sender: UIButton) {
        let vc = NewPostViewController()
        navigateTo(vc)
    }
    
    @IBAction func onClickedPostedBtn(_ sender: UIButton) {
        let vc = PostedViewController.instance(title: MainTitle.postedPosts)
        navigateTo(vc)
    }
    
    @IBAction func onClickedFavoritePostBtn(_ sender: UIButton) {
        let vc = PostedViewController.instance(title: MainTitle.favoritePosts)
        navigateTo(vc)
    }
    
    @IBAction func onClickedAccountDetailBtn(_ sender: UIButton) {
        let vc = AccountDetailViewController()
        navigateTo(vc)
    }
    
    @IBAction func onClickedSignOutBtn(_ sender: UIButton) {
        let vc = SignInViewController()
        navigateTo(vc)
    }
}
