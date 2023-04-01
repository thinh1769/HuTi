//
//  ConfirmPasswordViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 03/03/2023.
//

import UIKit

class ConfirmPasswordViewController: BaseViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var viewModel = ConfirmPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        isTouchDismissKeyboardEnabled = true

        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.password,
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
              pass == confirmPass
        else { return }
        showLoading()
        viewModel.register(password: pass).subscribe { [weak self] user in
            guard let self = self else { return }
            UserDefaults.userInfo = user
            UserDefaults.token = user.token
            self.hideLoading()
            self.setRootTabBar()
        }.disposed(by: viewModel.bag)
    }
}

extension ConfirmPasswordViewController {
    class func instance(phoneNumber: String, otp: String) -> ConfirmPasswordViewController {
        let controller = ConfirmPasswordViewController(nibName: ClassNibName.ConfirmPasswordViewController, bundle: Bundle.main)
        controller.viewModel.phoneNumber = phoneNumber
        controller.viewModel.otp = otp
        return controller
    }
}
