//
//  AccountDetailViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 10/03/2023.
//

import UIKit

class AccountDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

}

// MARK: - SetupUI.
extension AccountDetailViewController {
    private func setupUI() {
        isHiddenNavigationBar = true
        isTouchDismissKeyboardEnabled = true
    }

}

// MARK: - IBAction.
extension AccountDetailViewController {
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
}
