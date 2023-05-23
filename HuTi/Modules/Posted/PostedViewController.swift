//
//  PostedViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 13/03/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SVPullToRefresh

class PostedViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var postedTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var viewModel = PostedViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainTabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        loadData()
        titleLabel.text = viewModel.title
        setupTableView()
        addPullToRefresh()
        infiniteScroll()
        emptyView.isHidden = true
    }
    
    private func loadData() {
        if viewModel.title == MainTitle.postedPosts {
            getPostedPost()
        } else {
            getFavoritePost()
        }
    }
    
    private func getPostedPost() {
        viewModel.getPostedPost().subscribe { [weak self] postedPost in
            guard let self = self else { return }
            if postedPost.count > 0 {
                self.viewModel.appendPostToArray(posts: postedPost)
                self.viewModel.post.accept(self.viewModel.postList)
                self.emptyView.isHidden = true
            } else {
                self.emptyView.isHidden = false
            }
        }.disposed(by: viewModel.bag)
    }
    
    private func getFavoritePost() {
        viewModel.getFavoritePost().subscribe { [weak self] favoritePost in
            guard let self = self else { return }
            if favoritePost.count > 0 {
                self.viewModel.appendPostToArray(posts: favoritePost)
                self.viewModel.post.accept(self.viewModel.postList)
                self.emptyView.isHidden = true
            } else {
                self.emptyView.isHidden = false
            }
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
    
    private func addPullToRefresh() {
        postedTableView.addPullToRefresh { [weak self] in
            guard let self = self else { return }
            self.viewModel.page = 1
            self.viewModel.postList.removeAll()
            self.loadData()
            self.postedTableView.pullToRefreshView.stopAnimating()
        }
    }
    
    private func infiniteScroll() {
        postedTableView.addInfiniteScrolling { [weak self] in
            guard let self = self else { return }
            if self.viewModel.post.value.count >= CommonConstants.pageSize {
                self.viewModel.page += 1
                self.loadData()
            }
            self.postedTableView.infiniteScrollingView.stopAnimating()
        }
    }
}

extension PostedViewController: PostDetailViewControllerDelegate {
    func didTappedLikeButtonBackToMapView(_ postId: String) {
    }
    
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
