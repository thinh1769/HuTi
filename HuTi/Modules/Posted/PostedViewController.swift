//
//  PostedViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 13/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class PostedViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var postedTableView: UITableView!
    
    var viewModel = PostedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI.
extension PostedViewController {
    private func setupUI() {
        viewModel.initData()
        titleLabel.text = viewModel.title
        setupTableView()
    }
    
    private func setupTableView() {
        postedTableView.rowHeight = CommonConstants.tableRowHeight
        postedTableView.separatorStyle = .none
        
        postedTableView.register(FilterResultTableViewCell.nib, forCellReuseIdentifier: FilterResultTableViewCell.reusableIdentifier)
        
        viewModel.post.asObservable()
            .bind(to: postedTableView.rx.items(cellIdentifier: FilterResultTableViewCell.reusableIdentifier, cellType: FilterResultTableViewCell.self)) { [weak self] (index, element, cell) in
                guard let self = self else { return }
                if self.viewModel.title == MainTitle.favoritePosts {
                    cell.config(element, isHiddenAuthorAndHeart: false)
                } else {
                    cell.config(element, isHiddenAuthorAndHeart: true)
                }
            }.disposed(by: viewModel.bag)
        
        postedTableView.rx.modelSelected(Post.self)
            .subscribe { [weak self] element in
                guard let self = self else { return }
                print("table cell selected")
            }.disposed(by: viewModel.bag)
    }
}

// MARK: - IBAction.
extension PostedViewController {
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
}

// MARK: - Instance.
extension PostedViewController {
    class func instance(title: String) -> PostedViewController {
        let controller = PostedViewController(nibName: ClassNibName.PostedViewController, bundle: Bundle.main)
        controller.viewModel.title = title
        return controller
    }
}
