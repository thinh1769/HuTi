//
//  SignUpViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 15/02/2023.
//

import UIKit
import RxCocoa
import RxSwift

class SignUpViewController: BaseViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        emailTextField.delegate = self
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
        
        if !viewModel.isRegister {
            bottomStackView.isHidden = true
        } else {
            bottomStackView.isHidden = false
        }
    }
    
    @IBAction func onClickedSignInBtn(_ sender: UIButton) {
        let vc = SignInViewController()
        navigateTo(vc)
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    
    @IBAction func onClickedContinueBtn(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        showLoading()
        if viewModel.isRegister {
            viewModel.sendOTP(email: email)
                .subscribe { _ in
                } onError: { [weak self] _ in
                    guard let self = self else { return }
                    self.hideLoading()
                    self.showAlert(title: Alert.registedPhoneNumber)
                } onCompleted: { [weak self] in
                    guard let self = self else { return }
                    let vc = OTPViewController.instance(email: email, type: ConfirmPasswordType.register)
                    self.hideLoading()
                    self.navigateTo(vc)
                }.disposed(by: viewModel.bag)
        } else {
            viewModel.sendOTPResetPassword(email: email)
                .subscribe { _ in
                } onError: { [weak self] _ in
                    guard let self = self else { return }
                    self.hideLoading()
                    self.showAlert(title: Alert.nonRegistedPhoneNumber)
                } onCompleted: { [weak self] in
                    guard let self = self else { return }
                    let vc = OTPViewController.instance(email: email, type: ConfirmPasswordType.forgotPassword)
                    self.hideLoading()
                    self.navigateTo(vc)
                }.disposed(by: viewModel.bag)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 30
    }
}

extension SignUpViewController {
    class func instance(isRegister: Bool) -> SignUpViewController {
        let controller = SignUpViewController(nibName: ClassNibName.SignUpViewController, bundle: Bundle.main)
        controller.viewModel.isRegister = isRegister
        return controller
    }
}
