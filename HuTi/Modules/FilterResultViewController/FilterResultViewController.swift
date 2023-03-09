//
//  FilterResultViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class FilterResultViewController: BaseViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addressCollectionView: UICollectionView!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var mapButton: UIButton!
    @IBOutlet private weak var filterResultTableView: UITableView!
    
    var viewModel = FilterResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction func onClickedFilterBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickedMapBtn(_ sender: UIButton) {
    }
    
    
    private func setupUI() {
        viewModel.initData()
        isHiddenNavigationBar = true
        switch viewModel.tabBarItem {
        case 0:
            titleLabel.text = "Nhà đất bán"
        case 1:
            titleLabel.text = "Nhà đất cho thuê"
        case 2:
            titleLabel.text = "Dự án"
        default:
            titleLabel.text = "Nhà đất bán"
        }
        setupCollectionView()
        setupTableView()
    }
    
    private func setupCollectionView() {
        addressCollectionView.register(AddressCollectionViewCell.nib, forCellWithReuseIdentifier: AddressCollectionViewCell.reusableIdentifier)
        
        viewModel.address.asObservable()
            .bind(to: addressCollectionView.rx.items(cellIdentifier: AddressCollectionViewCell.reusableIdentifier, cellType: AddressCollectionViewCell.self)) { (index, element, cell) in
                cell.config(content: element)
            }.disposed(by: viewModel.bag)
        
        addressCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupTableView() {
        filterResultTableView.rowHeight = 130
        filterResultTableView.separatorStyle = .none
        
        filterResultTableView.register(FilterResultTableViewCell.nib, forCellReuseIdentifier: FilterResultTableViewCell.reusableIdentifier)
        
        viewModel.post.asObservable()
            .bind(to: filterResultTableView.rx.items(cellIdentifier: FilterResultTableViewCell.reusableIdentifier, cellType: FilterResultTableViewCell.self)) { (index, element, cell) in
                cell.postTitleLabel.text = element.title
                cell.priceLabel.text = element.price
                cell.addressLabel.text = element.address
                cell.authorLabel.text = element.authorName
            }.disposed(by: viewModel.bag)
        
        filterResultTableView.rx
            .modelSelected(Post.self)
            .subscribe { [weak self] element in
                guard let self = self else { return }
                print("table cell selected")
            }.disposed(by: viewModel.bag)
    }
    
}

extension FilterResultViewController {
    class func instance(tabBarItem: Int) -> FilterResultViewController {
        let controller = FilterResultViewController(nibName: "FilterResultViewController", bundle: Bundle.main)
        controller.viewModel.tabBarItem = tabBarItem
        return controller
    }
}

extension FilterResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = addressCollectionView.dequeueReusableCell(withReuseIdentifier: AddressCollectionViewCell.reusableIdentifier, for: indexPath) as! AddressCollectionViewCell
        let item = viewModel.address.value[indexPath.row]
        cell.config(content: item)
        let width = cell.contentLabel.intrinsicContentSize.width + 20
        return CGSize(width: width, height: 40)
    }
}
