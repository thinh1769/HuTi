//
//  PostDetailViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 16/03/2023.
//

import UIKit

class PostDetailViewController: BaseViewController {

    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var projectInfoView: UIView!
    
    var isLiked = false
    
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
    
    @IBAction func onClickedLikeButton(_ sender: UIButton) {
        if !isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = UIColor(named: ColorName.red)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = UIColor(named: ColorName.gray)
        }
        isLiked = !isLiked
    }
    
    @objc private func goToProjectDetailView() {
        let vc = ProjectDetailViewController()
        navigateTo(vc)
    }
    
}
