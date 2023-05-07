//
//  SignInViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 15/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: BaseViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var changeSecurePassTextFieldButton: UIButton!
    
    var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        emailTextField.text = "thinhnguyen@phenikaamaas.com"
        passwordTextField.text = "11111"
        passwordTextField.delegate = self
        emailTextField.delegate = self
        isHiddenMainTabBar = true
        isTouchDismissKeyboardEnabled = true
        
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.password,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
    }
    
    @IBAction func onClickedSignUpBtn(_ sender: UIButton) {
        let vc = SignUpViewController.instance(type: AuthenType.register)
        navigateTo(vc)
    }
    
    @IBAction func onClickedSignInBtn(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text,
              password.count > 4,
              password.count < 21
        else {
            self.showAlert(title: Alert.numberOfPass)
            return
        }
        showLoading()
        viewModel.signIn(email: email, password: password)
            .subscribe { [weak self] user in
                guard let self = self else { return}
                UserDefaults.userInfo = user
                UserDefaults.token = user.token
                self.hideLoading()
                self.setRootTabBar()
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.hideLoading()
                let er = error as! ServiceError
                if er.get() == "Tài khoản đã bị khóa!" {
                    self.showAlert(title: er.get())
                } else {
                    self.showAlert(title: Alert.wrongSignInInfo)
                }
            } onCompleted: {
                self.hideLoading()
            }.disposed(by: viewModel.bag)
    }
    
    @IBAction func didTapChangeSecurePassTextFieldButton(_ sender: UIButton) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            changeSecurePassTextFieldButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            changeSecurePassTextFieldButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @IBAction func onClickedForgotPasswordButton(_ sender: UIButton) {
        let vc = SignUpViewController.instance(type: AuthenType.forgotPassword)
        navigateTo(vc)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if textField == emailTextField {
            return newLength <= 30
        } else {
            return newLength <= 20
        }
    }
}
