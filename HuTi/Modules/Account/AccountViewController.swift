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
        guard let name = UserDefaults.userInfo?.name else {
            accountNameLabel.text = CommonConstants.updateInfo
            return
        }
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
            let vc = NewPostViewController()
            navigateTo(vc)
        } else {
            print("Vui lòng cập nhật thông tin tài khoản")
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

