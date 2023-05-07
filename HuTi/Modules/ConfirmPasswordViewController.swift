//
//  ConfirmPasswordViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 03/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ConfirmPasswordViewController: BaseViewController {
    
    @IBOutlet weak var oldPasswordView: UIView!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var oldPassChangeSecureTextButton: UIButton!
    @IBOutlet weak var passChangeSecureTextButton: UIButton!
    @IBOutlet weak var confirmPassChangeSecureTextButton: UIButton!
    
    var viewModel = ConfirmPasswordViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.type == ConfirmPasswordType.changePassword {
            oldPasswordView.isHidden = false
        } else {
            oldPasswordView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        isTouchDismissKeyboardEnabled = true
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self

        var passwordPlaceHolder = CommonConstants.password
        if viewModel.type == ConfirmPasswordType.changePassword {
            passwordPlaceHolder = "Mật khẩu mới"
        }
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: passwordPlaceHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.confirmPassword,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    
    @IBAction func onClickedContinueBtn(_ sender: UIButton) {
        guard let pass = passwordTextField.text,
              let confirmPass = confirmPasswordTextField.text,
              pass.count > 4,
              confirmPass.count > 4
        else {
            showAlert(title: Alert.numberOfPass)
            return
        }
        if pass != confirmPass {
            showAlert(title: Alert.notTheSamePass)
            return
        }
        if viewModel.type == ConfirmPasswordType.register {
            showLoading()
            viewModel.register(password: pass).subscribe { [weak self] user in
                guard let self = self else { return }
                UserDefaults.userInfo = user
                UserDefaults.token = user.token
                self.hideLoading()
                self.setRootTabBar()
            }.disposed(by: viewModel.bag)
        } else if viewModel.type == ConfirmPasswordType.forgotPassword {
            showLoading()
            viewModel.resetPassword(password: pass).subscribe { _ in
            } onError: { _ in
            } onCompleted: { [weak self] in
                guard let self = self else { return }
                let vc = SignInViewController()
                self.hideLoading()
                self.navigateTo(vc)
                self.showAlert(title: "Lấy lại mật khẩu thành công!\nMời đăng nhập lại")
            }.disposed(by: viewModel.bag)
        } else {
            guard let oldPass = oldPasswordTextField.text,
                  oldPass.count > 4
            else {
                showAlert(title: Alert.numberOfPass)
                return
            }
            if oldPass == pass {
                showAlert(title: "Mật khẩu mới trùng với mật khẩu hiện tại")
                return
            }
            showLoading()
            viewModel.changePassword(oldPassword: oldPass, newPassword: pass).subscribe { _ in
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.hideLoading()
                self.showAlert(title: "Mật khẩu hiện tại không đúng")
            } onCompleted: { [weak self] in
                guard let self = self else { return }
                self.hideLoading()
                self.backToPreviousView()
                self.showAlert(title: "Đổi mật khẩu thành công")
            }.disposed(by: viewModel.bag)
        }
    }
    
    @IBAction func didTapChangeSecureTextOldPassButton(_ sender: UIButton) {
        if oldPasswordTextField.isSecureTextEntry {
            oldPasswordTextField.isSecureTextEntry = false
            oldPassChangeSecureTextButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            oldPasswordTextField.isSecureTextEntry = true
            oldPassChangeSecureTextButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @IBAction func didTapChangeSecureTextPassButton(_ sender: UIButton) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            passChangeSecureTextButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            passChangeSecureTextButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @IBAction func didTapChangeSecureTextConfirmPassButton(_ sender: UIButton) {
        if confirmPasswordTextField.isSecureTextEntry {
            confirmPasswordTextField.isSecureTextEntry = false
            confirmPassChangeSecureTextButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            confirmPasswordTextField.isSecureTextEntry = true
            confirmPassChangeSecureTextButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
}

extension ConfirmPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 20
    }
}

extension ConfirmPasswordViewController {
    class func instance(email: String?, otp: String?, type: Int) -> ConfirmPasswordViewController {
        let controller = ConfirmPasswordViewController(nibName: ClassNibName.ConfirmPasswordViewController, bundle: Bundle.main)
        if let email = email {
            controller.viewModel.email = email
        }
        if let otp = otp {
            controller.viewModel.otp = otp
        }
        controller.viewModel.type = type
        return controller
    }
}
