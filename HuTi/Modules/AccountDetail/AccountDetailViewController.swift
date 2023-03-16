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
    
    private func setupUI() {
        isTouchDismissKeyboardEnabled = true
    }

    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
}
