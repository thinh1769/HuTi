//
//  AccountViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 09/03/2023.
//

import UIKit

class AccountViewController: BaseViewController {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var signedInStackView: UIStackView!
    
    var viewModel = AccountViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainTabBarController?.tabBar.isHidden = false
        guard let name = UserDefaults.userInfo?.name else { return }
        accountNameLabel.text = name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
    }
    
    @IBAction func onClickedNewPostBtn(_ sender: UIButton) {
        if viewModel.checkUpdateInfo() {
            let vc = NewPostViewController.instance(isEdit: false, postDetail: nil)
            navigateTo(vc)
        } else {
            showAlert(title: Alert.pleaseUpdateAccountInfo)
        }
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
        UserDefaults.userInfo = nil
        let vc = SignInViewController()
        navigateTo(vc)
    }
}

