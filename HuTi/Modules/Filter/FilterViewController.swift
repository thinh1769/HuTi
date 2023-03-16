//
//  FilterViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 15/03/2023.
//

import UIKit

class FilterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        isHiddenMainTabBar = true
        isTouchDismissKeyboardEnabled = true
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        isHiddenMainTabBar = false
        backToPreviousView()
    }
    
    @IBAction func onClickedApplyBtn(_ sender: UIButton) {
        isHiddenMainTabBar = false
        backToPreviousView()
    }
}

