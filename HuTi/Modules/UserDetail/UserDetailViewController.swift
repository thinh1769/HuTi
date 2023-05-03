//
//  UserDetailViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 03/05/2023.
//

import UIKit
import RxSwift
import RxCocoa

class UserDetailViewController: BaseViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var userInfoView: UIView!
    var viewModel = UserDetailViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainTabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupPostTableView()
        getUserInfo()
        getPostByUser()
        
        userInfoView.layer.masksToBounds = true
        userInfoView.layer.borderColor = UIColor(named: ColorName.themeText)?.cgColor
        userInfoView.layer.borderWidth = 1
    }
    
    private func getPostByUser() {
        viewModel.getPostByUser().subscribe { [weak self] posts in
            guard let self = self else { return }
            if posts.count > 0 {
                if self.viewModel.page == 1 {
                    let sortedPost = posts.sorted { $0.createdAt > $1.createdAt }
                    self.viewModel.post.accept(sortedPost)
                } else {
                    let mergePost = self.viewModel.post.value + posts
                    let sortedPost = mergePost.sorted { $0.createdAt > $1.createdAt }
                    self.viewModel.post.accept(sortedPost)
                }
            } else if self.viewModel.page == 1 {
                self.viewModel.post.accept([])
            }
        }.disposed(by: viewModel.bag)
    }
    
    private func getUserInfo() {
        viewModel.getUserById().subscribe { [weak self] user in
            guard let self = self else { return }
            self.viewModel.user = user
            self.loadUserInfo()
        }.disposed(by: viewModel.bag)
    }
    
    private func loadUserInfo() {
        guard let user = viewModel.user else { return }
        nameLabel.text = user.name
        phoneLabel.text = user.phoneNumber
        emailLabel.text = user.email ?? ""
    }
    
    private func setupPostTableView() {
        postTableView.rowHeight = 120
        postTableView.separatorStyle = .none
        postTableView.register(FilterResultTableViewCell.nib, forCellReuseIdentifier: FilterResultTableViewCell.reusableIdentifier)
        
        viewModel.post.asObservable()
            .bind(to: postTableView.rx.items(cellIdentifier: FilterResultTableViewCell.reusableIdentifier, cellType: FilterResultTableViewCell.self)) { (index, element, cell) in
                cell.configInfo(element, isHiddenAuthorAndHeart: true, isFavorite: self.isFavoritePost(postId: element.id))

            }.disposed(by: viewModel.bag)
        
        postTableView.rx
            .modelSelected(Post.self)
            .subscribe { [weak self] element in
                guard let self = self else { return }
                let vc = PostDetailViewController.instance(postId: element.id ?? "", isFavorite: self.isFavoritePost(postId: element.id ?? ""))
                self.navigateTo(vc)
            }.disposed(by: viewModel.bag)
        
        postTableViewAddPullToRefresh()
        postTableViewInfiniteScroll()
    }
    
    @IBAction func didTapCallButton(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://\(viewModel.user?.phoneNumber ?? "")") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        backToPreviousView()
    }
    
    private func postTableViewAddPullToRefresh() {
        postTableView.addPullToRefresh { [weak self] in
            guard let self = self else { return }
            self.postTableView.backgroundView = nil
            self.viewModel.post.accept([])
            self.viewModel.page = 1
            self.getPostByUser()
            self.postTableView.pullToRefreshView.stopAnimating()
        }
    }
    
    private func postTableViewInfiniteScroll() {
        if viewModel.post.value.count >= CommonConstants.pageSize {
            postTableView.addInfiniteScrolling { [weak self] in
                guard let self = self else { return }
                self.viewModel.page += 1
                self.getPostByUser()
                self.postTableView.infiniteScrollingView.stopAnimating()
            }
        }
    }
}

extension UserDetailViewController {
    class func instance(userId: String) -> UserDetailViewController {
        let controller = UserDetailViewController(nibName: ClassNibName.UserDetailViewController, bundle: Bundle.main)
        controller.viewModel.userId = userId
        return controller
    }
}
