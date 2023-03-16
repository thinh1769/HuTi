//
//  PostDetailViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 16/03/2023.
//

import UIKit

class PostDetailViewController: BaseViewController {

    
    @IBOutlet weak var projectInfoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        projectInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProjectDetailView)))
    }

    private func setupUI() {
        
    }
  
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    
    @objc private func goToProjectDetailView() {
        let vc = ProjectDetailViewController()
        navigateTo(vc)
    }
    
}
