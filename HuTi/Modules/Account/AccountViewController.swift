//
//  AccountViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 09/03/2023.
//

import UIKit

class AccountViewController: BaseViewController {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signedInStackView: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        guard let isLogin = UserDefaults.isSignIn else { return }
        if isLogin {
            signInBtn.isHidden = true
            signedInStackView.isHidden = false
        } else {
            accountNameLabel.text = CommonConstants.notSignIn
            signInBtn.isHidden = false
            signedInStackView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
    }
    
    @IBAction func onClickedSignInBtn(_ sender: UIButton) {
        let vc = SignInViewController()
        navigateTo(vc)
    }
    
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
        UserDefaults.isSignIn = false
        let vc = SignInViewController()
        navigateTo(vc)
    }
}

