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
    
    private func setupUI() {
        
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
}
