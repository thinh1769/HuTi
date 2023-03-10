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
    
    private func setupUI() {
        isHiddenNavigationBar = true
    }
    
    @IBAction func onClickedNewPostBtn(_ sender: UIButton) {
    }
    
    @IBAction func onClickedPostedBtn(_ sender: UIButton) {
    }
    
    @IBAction func onClickedFavoritePostBtn(_ sender: UIButton) {
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
