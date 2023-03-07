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
    }
    
    private func setupTableView() {
        filterResultTableView.rowHeight = 120
        filterResultTableView.separatorStyle = .none
        
        filterResultTableView.register(FilterResultTableViewCell.nib, forCellReuseIdentifier: FilterResultTableViewCell.reusableIdentifier)
        
        viewModel.post.asObservable()
            .bind(to: filterResultTableView.rx.items(cellIdentifier: FilterResultTableViewCell.reusableIdentifier, cellType: FilterResultTableViewCell.self)) { (index, element, cell) in
                
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
