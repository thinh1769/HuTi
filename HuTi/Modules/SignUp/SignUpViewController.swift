//
//  SignUpViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 15/02/2023.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet private weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        isHiddenNavigationBar = true
        
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
        let vc = OTPViewController()
        navigateTo(vc)
    }
}
