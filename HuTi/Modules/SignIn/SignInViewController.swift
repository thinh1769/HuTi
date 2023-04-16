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
        passwordTextField.delegate = self
        phoneTextField.delegate = self
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
              phoneNumber.count == 10
        else {
            self.showAlert(title: Alert.numberOfPhoneNumber)
            return
        }
        guard let password = passwordTextField.text,
              password.count > 4,
              password.count < 21
        else {
            self.showAlert(title: Alert.numberOfPass)
            return
        }
        showLoading()
        viewModel.signIn(phoneNumber: phoneNumber, password: password)
            .subscribe { [weak self] user in
                guard let self = self else { return}
                UserDefaults.userInfo = user
                UserDefaults.token = user.token
                self.hideLoading()
                self.setRootTabBar()
            } onError: { [weak self] _ in
                guard let self = self else { return }
                self.hideLoading()
                self.showAlert(title: Alert.wrongSignInInfo)
            } onCompleted: {
                self.hideLoading()
            }.disposed(by: viewModel.bag)
    }
    
    
    @IBAction func onClickedForgotPasswordButton(_ sender: UIButton) {
        let vc = SignUpViewController.instance(isRegister: false)
        navigateTo(vc)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if textField == phoneTextField {
            return newLength <= 10
        } else {
            return newLength <= 20
        }
    }
}
