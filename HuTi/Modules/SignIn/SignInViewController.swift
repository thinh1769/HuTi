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
    
    var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        phoneTextField.text = "0000099999"
        passwordTextField.text = "11111"
        isHiddenMainTabBar = true
        isTouchDismissKeyboardEnabled = true
        
        phoneTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.phoneNumber,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.password,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
    }
    
    @IBAction func onClickedSignUpBtn(_ sender: UIButton) {
        let vc = SignUpViewController.instance(isRegister: true)
        navigateTo(vc)
    }
    
    @IBAction func onClickedSignInBtn(_ sender: UIButton) {
        guard let phoneNumber = phoneTextField.text,
              phoneNumber.count == 10,
              let password = passwordTextField.text,
              password.count > 4
        else { return }
        showLoading()
        viewModel.signIn(phoneNumber: phoneNumber, password: password)
            .subscribe { [weak self] user in
                guard let self = self else { return}
                UserDefaults.userInfo = user
                UserDefaults.token = user.token
                self.hideLoading()
                self.setRootTabBar()
            } onError: { _ in
                self.hideLoading()
            } onCompleted: {
                self.hideLoading()
            }.disposed(by: viewModel.bag)
    }
    
    
    @IBAction func onClickedForgotPasswordButton(_ sender: UIButton) {
        let vc = SignUpViewController.instance(isRegister: false)
        navigateTo(vc)
    }
}
