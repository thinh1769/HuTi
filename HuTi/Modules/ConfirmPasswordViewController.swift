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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI.
extension ConfirmPasswordViewController {
    private func setupUI() {
        isTouchDismissKeyboardEnabled = true
        isHiddenNavigationBar = true
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.password,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: CommonConstants.confirmPassword,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
    }
}

// MARK: - IBAction.
extension ConfirmPasswordViewController {
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    
    @IBAction func onClickedContinueBtn(_ sender: UIButton) {
        setRootTabBar()
    }
}
