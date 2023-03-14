//
//  NewPostViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 14/03/2023.
//

import UIKit

class NewPostViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

// MARK: - SetupUI.
extension NewPostViewController {
    private func setupUI() {
        
    }
}

// MARK: - SetupUI.
extension NewPostViewController {
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
}
