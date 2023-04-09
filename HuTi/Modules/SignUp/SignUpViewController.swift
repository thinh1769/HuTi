//
//  SignUpViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 15/02/2023.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        phoneTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.phoneNumber,
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
        guard let phoneNumber = phoneTextField.text,
              phoneNumber.count == 10
        else { return }
        showLoading()
        if viewModel.isRegister {
            viewModel.sendOTP(phoneNumber: phoneNumber)
                .subscribe { _ in
                } onError: { _ in
                    self.hideLoading()
                } onCompleted: { [weak self] in
                    guard let self = self else { return }
                    let vc = OTPViewController.instance(phoneNumber: phoneNumber, isRegister: true)
                    self.hideLoading()
                    self.navigateTo(vc)
                }.disposed(by: viewModel.bag)
        } else {
            viewModel.sendOTPResetPassword(phoneNumber: phoneNumber)
                .subscribe { _ in
                } onError: { [weak self] _ in
                    guard let self = self else { return }
                    self.hideLoading()
                } onCompleted: { [weak self] in
                    guard let self = self else { return }
                    let vc = OTPViewController.instance(phoneNumber: phoneNumber, isRegister: false)
                    self.hideLoading()
                    self.navigateTo(vc)
                }.disposed(by: viewModel.bag)
        }
    }
}

extension SignUpViewController {
    class func instance(isRegister: Bool) -> SignUpViewController {
        let controller = SignUpViewController(nibName: ClassNibName.SignUpViewController, bundle: Bundle.main)
        controller.viewModel.isRegister = isRegister
        return controller
    }
}
