//
//  PostedViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 13/03/2023.
//

import UIKit

class PostedViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var postedTableView: UITableView!
    
    var viewModel = PostedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        if viewModel.title == MainTitle.postedPosts {
            getPostedPost()
        } else {
            getFavoritePost()
        }
        titleLabel.text = viewModel.title
        setupTableView()
    }
    
    private func getPostedPost() {
        viewModel.getPostedPost().subscribe { [weak self] postedPost in
            guard let self = self else { return }
            self.viewModel.post.accept(postedPost)
        }.disposed(by: viewModel.bag)
    }
    
    private func getFavoritePost() {
        viewModel.getFavoritePost().subscribe { [weak self] favoritePost in
            guard let self = self else { return }
            self.viewModel.post.accept(favoritePost)
        }.disposed(by: viewModel.bag)
    }
    
    private func setupTableView() {
        postedTableView.rowHeight = CommonConstants.tableRowHeight
        postedTableView.separatorStyle = .none
        
        postedTableView.register(FilterResultTableViewCell.nib, forCellReuseIdentifier: FilterResultTableViewCell.reusableIdentifier)
        
        viewModel.post.asObservable()
            .bind(to: postedTableView.rx.items(cellIdentifier: FilterResultTableViewCell.reusableIdentifier, cellType: FilterResultTableViewCell.self)) { [weak self] (index, element, cell) in
                guard let self = self else { return }
                if self.viewModel.title == MainTitle.favoritePosts {
                    cell.configInfo(element, isHiddenAuthorAndHeart: false, isFavorite: self.isFavoritePost(postId: element.id))
                } else {
                    cell.configInfo(element, isHiddenAuthorAndHeart: true, isFavorite: self.isFavoritePost(postId: element.id))
                }
            }.disposed(by: viewModel.bag)
        
        postedTableView.rx.modelSelected(Post.self)
            .subscribe { [weak self] element in
                guard let self = self else { return }
                let vc = PostDetailViewController.instance(postId: element.id ?? "", isFavorite: self.isFavoritePost(postId: element.id))
                vc.delegate = self
                self.navigateTo(vc)
            }.disposed(by: viewModel.bag)
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
}

extension PostedViewController: PostDetailViewControllerDelegate {
    func didTappedLikeButton() {
        postedTableView.reloadData()
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
