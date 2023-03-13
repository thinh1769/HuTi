//
//  SignInViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 15/02/2023.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        isHiddenMainTabBar = true
        isTouchDismissKeyboardEnabled = true
        isHiddenNavigationBar = true
        
        phoneTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.phoneNumber,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.phoneNumber,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
    }

    @IBAction func onClickedSignUpBtn(_ sender: UIButton) {
        let vc = SignUpViewController()
        navigateTo(vc)
    }
    
    @IBAction func onClickedSignInBtn(_ sender: UIButton) {
        setRootTabBar()
    }
}
