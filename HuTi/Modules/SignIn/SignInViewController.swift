//
//  SignInViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 15/02/2023.
//

import UIKit

class SignInViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        isHiddenMainTabBar = true
        isTouchDismissKeyboardEnabled = true
        isHiddenNavigationBar = true
    }

    @IBAction func onClickedSignUpBtn(_ sender: UIButton) {
        let vc = SignUpViewController()
        navigateTo(vc)
    }
    
    @IBAction func onClickedSignInBtn(_ sender: UIButton) {
        setRootTabBar()
    }
}
