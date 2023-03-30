//
//  SignUpViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 15/02/2023.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet private weak var phoneTextField: UITextField!
    
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
    }
    
    @IBAction func onClickedSignInBtn(_ sender: UIButton) {
        let vc = SignInViewController()
        navigateTo(vc)
    }
    
    @IBAction func onClickedContinueBtn(_ sender: UIButton) {
        guard let phoneNumber = phoneTextField.text,
              phoneNumber.count == 10
        else { return }
        viewModel.sendOTP(phoneNumber: phoneNumber)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                let vc = OTPViewController.instance(phoneNumber: phoneNumber)
                self.navigateTo(vc)
            }.disposed(by: viewModel.bag)
    }
}
