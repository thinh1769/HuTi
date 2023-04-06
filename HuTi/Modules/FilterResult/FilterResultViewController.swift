//
//  FilterResultViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

class FilterResultViewController: BaseViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addressCollectionView: UICollectionView!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var mapButton: UIButton!
    @IBOutlet private weak var filterResultTableView: UITableView!
    @IBOutlet private weak var mapView: MKMapView!
    
    var viewModel = FilterResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        loadData()
        mapView.isHidden = true
        titleLabel.text = viewModel.mainTabBarItemTitle
        setupCollectionView()
        setupTableView()
    }
    
    private func loadData() {
        if viewModel.tabBarItemTitle != TabBarItemTitle.project {
            getListPosts()
        } else {
            getListProjects()
        }
    }
    
    private func getListPosts() {
        var isSell = true
        if viewModel.tabBarItemTitle == TabBarItemTitle.forRent {
            isSell = false
        }
        viewModel.getListPosts(isSell: isSell).subscribe { [weak self] posts in
            guard let self = self else { return}
            self.viewModel.post.accept(posts)
        }.disposed(by: viewModel.bag)
    }
    
    private func getListProjects() {
        viewModel.getListProjects().subscribe { [weak self] projects in
            guard let self = self else { return }
            self.viewModel.project.accept(projects)
        }.disposed(by: viewModel.bag)
    }
    
    private func setupCollectionView() {
        addressCollectionView.register(AddressCollectionViewCell.nib, forCellWithReuseIdentifier: AddressCollectionViewCell.reusableIdentifier)
        
        viewModel.options.asObservable()
            .bind(to: addressCollectionView.rx.items(cellIdentifier: AddressCollectionViewCell.reusableIdentifier, cellType: AddressCollectionViewCell.self)) { (index, element, cell) in
                cell.config(content: element)
            }.disposed(by: viewModel.bag)
        
        addressCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupTableView() {
        filterResultTableView.rowHeight = CommonConstants.tableRowHeight
        filterResultTableView.separatorStyle = .none
        
        filterResultTableView.register(FilterResultTableViewCell.nib, forCellReuseIdentifier: FilterResultTableViewCell.reusableIdentifier)
        
        viewModel.post.asObservable()
            .bind(to: filterResultTableView.rx.items(cellIdentifier: FilterResultTableViewCell.reusableIdentifier, cellType: FilterResultTableViewCell.self)) { (index, element, cell) in
                cell.configInfo(element, isHiddenAuthorAndHeart: false)
                self.viewModel.getImage(remoteName: element.thumbnail) { thumbnail in
                    DispatchQueue.main.async {
                        cell.loadThumbnail(thumbnail: thumbnail)
                    }
                }
            }.disposed(by: viewModel.bag)
        
        filterResultTableView.rx
            .modelSelected(Post.self)
            .subscribe { [weak self] element in
                guard let self = self else { return }
                if self.viewModel.tabBarItemTitle == TabBarItemTitle.project {
                    let vc = ProjectDetailViewController()
                    self.navigateTo(vc)
                } else {
                    let vc = PostDetailViewController.instance(postId: element.id ?? "")
                    self.navigateTo(vc)
                }
            }.disposed(by: viewModel.bag)
    }
    
    @IBAction func onClickedFilterBtn(_ sender: UIButton) {
        let vc = FilterViewController.instance(tabBarItemTitle: viewModel.tabBarItemTitle)
        vc.delegate = self
        if viewModel.options.value.count > 1 {
            vc.configSelectedOptions(optionsList: viewModel.tuppleOptionsList)
        }
        navigateTo(vc)
    }
    
    @IBAction func onClickedMapBtn(_ sender: UIButton) {
        mapView.isHidden = !mapView.isHidden
        filterResultTableView.isHidden = !filterResultTableView.isHidden
        if !mapView.isHidden {
            mapButton.setImage(UIImage(named: ImageName.list), for: .normal)
        } else {
            mapButton.setImage(UIImage(systemName: ImageName.map), for: .normal)
        }
    }
}

extension FilterResultViewController: FilterViewControllerDelegate {
    func didTapApplyButton(listOptions: [(Int, String)], postResult: [Post]?, projectResult: [Project]?) {
        viewModel.tuppleOptionsList = listOptions
        viewModel.parseOptionTuppleToArray()
        if let filterPost = postResult {
            viewModel.post.accept(filterPost)
        }
        if let filterProject = projectResult {
            viewModel.project.accept(filterProject)
        }
    }
    
    func didTapResetButton() {
        viewModel.optionsList = []
        viewModel.options.accept(viewModel.optionsList)
        if viewModel.tabBarItemTitle == TabBarItemTitle.project {
            getListProjects()
        } else {
            getListPosts()
        }
    }
}

// MARK: - Instance.
extension FilterResultViewController {
    class func instance(mainTabBarItemTitle: String, tabBarItemTitle: String) -> FilterResultViewController {
        let controller = FilterResultViewController(nibName: ClassNibName.FilterResultViewController, bundle: Bundle.main)
        controller.viewModel.mainTabBarItemTitle = mainTabBarItemTitle
        controller.viewModel.tabBarItemTitle = tabBarItemTitle
        return controller
    }
}

// MARK: - Kích thước collectionView cell.
extension FilterResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = addressCollectionView.dequeueReusableCell(withReuseIdentifier: AddressCollectionViewCell.reusableIdentifier, for: indexPath) as! AddressCollectionViewCell
        let item = viewModel.options.value[indexPath.row]
        cell.config(content: item)
        let width = cell.contentLabel.intrinsicContentSize.width + 20
        return CGSize(width: width, height: 40)
    }
}
