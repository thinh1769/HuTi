//
//  ConfirmPasswordViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 03/03/2023.
//

import UIKit

class ConfirmPasswordViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
 
    private func setupUI() {
        isTouchDismissKeyboardEnabled = true
        isHiddenNavigationBar = true
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickedContinueBtn(_ sender: UIButton) {
        setRootTabBar()
    }
}
