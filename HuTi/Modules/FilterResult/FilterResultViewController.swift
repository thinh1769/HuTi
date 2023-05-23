//
//  FilterResultViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift
import RxCocoa

class FilterResultViewController: BaseViewController {
    
    @IBOutlet private weak var optionView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var optionCollectionView: UICollectionView!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var mapButton: UIButton!
    @IBOutlet private weak var filterResultTableView: UITableView!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet weak var userLocationButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    var viewModel = FilterResultViewModel()
    private var locationManager = CLLocationManager()
    private let provinceSpan = MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
    private let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    private let postSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    var detailViewBottomConstraint: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainTabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        mapView.delegate = self
        mapView.isHidden = true
        emptyView.isHidden = true
        userLocationButton.isHidden = true
        userLocationButton.layer.masksToBounds = true
        userLocationButton.layer.borderColor = UIColor(named: ColorName.gray)?.cgColor
        userLocationButton.layer.borderWidth = 1
        
        optionView.isHidden = true
        searchView.isHidden = false
        var placeHolder = "Nhập tên đường"
        if viewModel.tabBarItemTitle == TabBarItemTitle.project {
            placeHolder = "Nhập tên dự án"
        }
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorName.gray)!]
        )
        titleLabel.text = viewModel.mainTabBarItemTitle
        setupCollectionView()
        setupTableView()
        filterResultAddPullToRefresh()
        filterResultInfiniteScroll()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        if let tabBar = tabBarController?.tabBar {
            detailViewBottomConstraint = tabBar.bounds.height
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDetailPopupView))
        self.mapView.addGestureRecognizer(tapGesture)
    }
    
    private func loadData() {
        if viewModel.tabBarItemTitle != TabBarItemTitle.project {
            findPost(param: viewModel.getApprovedPostParam)
        } else {
            findProject(param: viewModel.findProjectParams)
            mapButton.isHidden = true
        }
    }
    
    private func setupCollectionView() {
        optionCollectionView.register(AddressCollectionViewCell.nib, forCellWithReuseIdentifier: AddressCollectionViewCell.reusableIdentifier)
        
        viewModel.options.asObservable()
            .bind(to: optionCollectionView.rx.items(cellIdentifier: AddressCollectionViewCell.reusableIdentifier, cellType: AddressCollectionViewCell.self)) { (index, element, cell) in
                cell.config(content: element)
            }.disposed(by: viewModel.bag)
        
        optionCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupTableView() {
        filterResultTableView.rowHeight = CommonConstants.tableRowHeight
        filterResultTableView.separatorStyle = .none
        
        if viewModel.tabBarItemTitle == TabBarItemTitle.project {
            setupProjectTableView()
        } else {
            setupPostTableView()
        }
    }
    
    private func setupPostTableView() {
        filterResultTableView.register(FilterResultTableViewCell.nib, forCellReuseIdentifier: FilterResultTableViewCell.reusableIdentifier)
        
        viewModel.post.asObservable()
            .bind(to: filterResultTableView.rx.items(cellIdentifier: FilterResultTableViewCell.reusableIdentifier, cellType: FilterResultTableViewCell.self)) { (index, element, cell) in
                cell.configInfo(element, isHiddenAuthorAndHeart: false, isFavorite: self.isFavoritePost(postId: element.id))
            }.disposed(by: viewModel.bag)
        
        filterResultTableView.rx
            .modelSelected(Post.self)
            .subscribe { [weak self] element in
                guard let self = self else { return }
                let vc = PostDetailViewController.instance(postId: element.id ?? "", isFavorite: self.isFavoritePost(postId: element.id))
                vc.delegate = self
                self.navigateTo(vc)
            }.disposed(by: viewModel.bag)
    }
    
    private func setupProjectTableView() {
        filterResultTableView.register(ProjectFilterResultTableViewCell.nib, forCellReuseIdentifier: ProjectFilterResultTableViewCell.reusableIdentifier)
        
        viewModel.project.asObservable()
            .bind(to: filterResultTableView.rx.items(cellIdentifier: ProjectFilterResultTableViewCell.reusableIdentifier, cellType: ProjectFilterResultTableViewCell.self)) { (index, element, cell) in
                cell.config(project: element)
            }.disposed(by: viewModel.bag)
        
        filterResultTableView.rx
            .modelSelected(Project.self)
            .subscribe { [weak self] element in
                guard let self = self else { return }
                let vc = ProjectDetailViewController.instance(projectId: element.id ?? "")
                self.navigateTo(vc)
            }.disposed(by: viewModel.bag)
    }
    
    @IBAction func onClickedFilterBtn(_ sender: UIButton) {
        let vc = FilterViewController.instance(tabBarItemTitle: viewModel.tabBarItemTitle)
        vc.delegate = self
        if viewModel.options.value.count > 1 {
            vc.configSelectedOptions(optionsList: viewModel.tuppleOptionsList, selectedProvince: viewModel.selectedProvince, selectedDistrict: viewModel.selectedDistrict)
        }
        navigateTo(vc)
    }
    
    @IBAction func onClickedMapBtn(_ sender: UIButton) {
        mapView.isHidden = !mapView.isHidden
        userLocationButton.isHidden = !userLocationButton.isHidden
        filterResultTableView.isHidden = !filterResultTableView.isHidden
        if !mapView.isHidden {
            mapButton.setImage(UIImage(named: ImageName.list), for: .normal)
            emptyView.isHidden = true
        } else {
            for subview in view.subviews{
                if subview.tag == SubviewTag.detailView.rawValue {
                    subview.removeFromSuperview()
                }
            }
            deselectedAnnotationWhenDismissDetailPopup()
            mapButton.setImage(UIImage(systemName: ImageName.map), for: .normal)
            
            if viewModel.tabBarItemTitle == TabBarItemTitle.project {
                if viewModel.project.value.count == 0 {
                    emptyView.isHidden = false
                } else {
                    emptyView.isHidden = true
                }
            } else if viewModel.post.value.count == 0 {
                emptyView.isHidden = false
            } else {
                emptyView.isHidden = true
            }
        }
    }
    
    @IBAction func onClickedUserLocationButton(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    @objc private func dismissDetailPopupView() {
        for subview in view.subviews {
            if subview.tag == SubviewTag.detailView.rawValue {
                UIView.animateKeyframes(withDuration: 0.4, delay: 0) {
                    subview.transform = CGAffineTransform(translationX: 0, y: 215)
                } completion: { _ in
                    subview.removeFromSuperview()
                }
            }
        }
    }
    
    private func filterResultAddPullToRefresh() {
        filterResultTableView.addPullToRefresh { [weak self] in
            guard let self = self else { return }
            self.filterResultTableView.backgroundView = nil
            self.refreshData()
            self.filterResultTableView.pullToRefreshView.stopAnimating()
        }
    }
    
    private func refreshData() {
        viewModel.optionsList = []
        viewModel.options.accept(viewModel.optionsList)
        viewModel.page = 1
        optionView.isHidden = true
        searchView.isHidden = false
        searchTextField.text = ""
        if viewModel.tabBarItemTitle == TabBarItemTitle.project {
            viewModel.project.accept([])
            viewModel.findProjectParams = [String: Any]()
            findProject(param: viewModel.findProjectParams)
        } else {
            viewModel.post.accept([])
            findPost(param: viewModel.getApprovedPostParam)
        }
    }
    
    private func filterResultInfiniteScroll() {
        filterResultTableView.addInfiniteScrolling { [weak self] in
            guard let self = self else { return }
            if self.viewModel.options.value.count > 0 {
                self.viewModel.page += 1
                if self.viewModel.tabBarItemTitle != TabBarItemTitle.project {
                    if self.viewModel.post.value.count >= CommonConstants.pageSize {
                        self.findPost(param: self.viewModel.findPostParams)
                    }
                } else if self.viewModel.project.value.count >= CommonConstants.pageSize {
                    self.findProject(param: self.viewModel.findProjectParams)
                }
            } else if let text = self.searchTextField.text,
                      text.count > 0 {
                if self.viewModel.tabBarItemTitle != TabBarItemTitle.project {
                    if self.viewModel.post.value.count >= CommonConstants.pageSize {
                        self.viewModel.page += 1
                        self.searchByKeyword(keyword: text)
                    }
                } else {
                    if self.viewModel.project.value.count >= CommonConstants.pageSize {
                        self.viewModel.page += 1
                        self.searchByKeyword(keyword: text)
                    }
                }
            } else {
                if self.viewModel.tabBarItemTitle != TabBarItemTitle.project {
                    if self.viewModel.post.value.count >= CommonConstants.pageSize {
                        self.viewModel.page += 1
                        self.loadData()
                    }
                } else {
                    if self.viewModel.project.value.count >= CommonConstants.pageSize {
                        self.viewModel.page += 1
                        self.loadData()
                    }
                }
            }
            self.filterResultTableView.infiniteScrollingView.stopAnimating()
        }
    }
    
    private func findPost(param: [String: Any]) {
        var findParams = param
        var isSell = true
        if viewModel.tabBarItemTitle == TabBarItemTitle.forRent {
            isSell = false
        }
        findParams.updateValue(isSell, forKey: "isSell")
        viewModel.findPost(param: findParams).subscribe { [weak self] posts in
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
                self.pinRealEstateLocation()
                self.subtitleLabel.text = "\(CommonConstants.firstSubtitle) \(self.viewModel.post.value.count) \(CommonConstants.realEstate)"
                self.emptyView.isHidden = true
            } else if self.viewModel.page == 1 {
                self.viewModel.post.accept([])
                self.emptyView.isHidden = false
                self.removeAnnotation()
                self.subtitleLabel.text = "\(CommonConstants.firstSubtitle) \(self.viewModel.post.value.count) \(CommonConstants.realEstate)"
            }
        }.disposed(by: viewModel.bag)
    }
    
    private func findProject(param: [String: Any]) {
        viewModel.findProject(param: param).subscribe { [weak self] projects in
            guard let self = self else { return }
            if projects.count > 0 {
                if self.viewModel.page == 1 {
                    self.viewModel.project.accept(projects)
                } else {
                    self.viewModel.project.accept(self.viewModel.project.value + projects)
                }
                self.subtitleLabel.text = "\(CommonConstants.firstSubtitle) \(self.viewModel.project.value.count) \(CommonConstants.project)"
                self.emptyView.isHidden = true
            } else if self.viewModel.page == 1 {
                self.viewModel.project.accept([])
                self.subtitleLabel.text = "\(CommonConstants.firstSubtitle) \(self.viewModel.project.value.count) \(CommonConstants.project)"
                self.emptyView.isHidden = false
            }
        }.disposed(by: viewModel.bag)
    }
    
    @IBAction func didTapSearchByKeyword(_ sender: UIButton) {
        guard let keyword = searchTextField.text,
              keyword.count > 0
        else {
            showAlert(title: "Vui lòng nhập thông tin vào ô tìm kiếm")
            return
        }
        searchByKeyword(keyword: keyword)
    }
    
    private func searchByKeyword(keyword: String) {
        viewModel.page = 1
        if viewModel.tabBarItemTitle == TabBarItemTitle.project {
            viewModel.project.accept([])
            searchProjectByKeyword(keyword: keyword)
        } else {
            viewModel.post.accept([])
            searchPostByKeyword(keyword: keyword)
        }
    }
    
    private func searchPostByKeyword(keyword: String) {
        viewModel.searchPostByKeyword(keyword: keyword).subscribe { [weak self] listPost in
            guard let self = self else { return }
            let posts = self.viewModel.filterPostAfterSearchByKeyword(posts: listPost)
            if posts.count > 0 {
                if self.viewModel.page == 1 {
                    self.viewModel.post.accept(posts)
                } else {
                    self.viewModel.post.accept(self.viewModel.post.value + posts)
                }
                self.subtitleLabel.text = "\(CommonConstants.firstSubtitle) \(self.viewModel.post.value.count) \(CommonConstants.realEstate)"
                self.pinRealEstateLocation()
            } else if self.viewModel.page == 1 {
                self.viewModel.post.accept([])
                self.subtitleLabel.text = "\(CommonConstants.firstSubtitle) \(self.viewModel.post.value.count) \(CommonConstants.realEstate)"
            }
        }.disposed(by: viewModel.bag)
    }
    
    private func searchProjectByKeyword(keyword: String) {
        viewModel.searchProjectByKeyword(keyword: keyword).subscribe { [weak self] projects in
            guard let self = self else { return }
            if projects.count > 0 {
                if self.viewModel.page == 1 {
                    self.viewModel.project.accept(projects)
                } else {
                    self.viewModel.project.accept(self.viewModel.project.value + projects)
                }
                self.subtitleLabel.text = "\(CommonConstants.firstSubtitle) \(self.viewModel.project.value.count) \(CommonConstants.project)"
            } else if self.viewModel.page == 1 {
                self.viewModel.project.accept([])
                self.subtitleLabel.text = "\(CommonConstants.firstSubtitle) \(self.viewModel.project.value.count) \(CommonConstants.project)"
            }
        }.disposed(by: viewModel.bag)
    }
    
}

extension FilterResultViewController: FilterViewControllerDelegate {
    func didTapApplyButton(listOptions: [(Int, String)], findPostParams: [String : Any]?, findProjectParams: [String : Any]?, selectedProvince: (index: Int, id: String), selectedDistrict: (index: Int, id: String)) {
        viewModel.tuppleOptionsList = listOptions
        viewModel.parseOptionTuppleToArray()
        viewModel.selectedProvince = selectedProvince
        viewModel.selectedDistrict = selectedDistrict
        viewModel.page = 1
        optionView.isHidden = false
        searchView.isHidden = true
        
        if let param = findPostParams {
            viewModel.findPostParams = param
            findPost(param: viewModel.findPostParams)
        }
        
        if let param = findProjectParams {
            viewModel.findProjectParams = param
            findProject(param: viewModel.findProjectParams)
        }
    }
    
    func didTapResetButton() {
        refreshData()
    }
}

extension FilterResultViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = true
            moveCameraToLocation(location.coordinate.latitude, location.coordinate.longitude)
        }
    }
    
    private func moveCameraToLocation(_ lat: Double, _ long: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    private func pinRealEstateLocation() {
        removeAnnotation()
        let posts = viewModel.post.value
        if posts.count > 0 {
            for post in posts {
                let coordinate = CLLocationCoordinate2D(latitude: post.lat, longitude: post.long)
                let pin = MKPointAnnotation()
                pin.title = post.id
                pin.coordinate = coordinate
                mapView.addAnnotation(pin)
            }
        }
    }
    
    private func removeAnnotation() {
        let annotations = mapView.annotations
        for annotation in annotations {
            if let annotation = annotation as? MKAnnotation {
                mapView.removeAnnotation(annotation)
            }
        }
    }
}

extension FilterResultViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "location")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "location")
        } else {
            annotationView?.annotation = annotation
        }
        
        let image = UIImage(named: "location")
        let resizedSize = CGSize(width: 30, height: 30)
        
        UIGraphicsBeginImageContext(resizedSize)
        image?.draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        annotationView?.image = resizedImage
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        print("did tap pin")
        let coordinate = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: postSpan)
        mapView.setRegion(region, animated: true)
        
        guard let tempId = annotation.title,
              let id = tempId
        else { return }
        self.view.endEditing(true)
        addDetailView(id)
    }
    
    private func addDetailView(_ id: String) {
        for subview in view.subviews{
            if subview.tag == SubviewTag.detailView.rawValue {
                subview.removeFromSuperview()
            }
        }
        let detailView = DetailPopupView()
        detailView.delegate = self
        detailView.configHeartIcon(isFavoritePost(postId: id))
        detailView.loadData(viewModel.post.value[viewModel.getIndexOfSelectedPost(postId: id)])
        detailView.tag = SubviewTag.detailView.rawValue

        if detailView.superview == nil {
            self.view.addSubview(detailView)
            detailView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -detailViewBottomConstraint),
                detailView.heightAnchor.constraint(equalToConstant: 170)
            ])
        }
    }
}

extension FilterResultViewController: PostDetailViewControllerDelegate {
    func didTappedLikeButtonBackToMapView(_ postId: String) {
        if !mapView.isHidden {
            self.addDetailView(postId)
        }
    }
    
    func didTappedLikeButton() {
        filterResultTableView.reloadData()
    }
}

extension FilterResultViewController: DetailPopupViewDelegate {
    func deselectedAnnotationWhenDismissDetailPopup() {
        let annotations = mapView.annotations
        for annotation in annotations {
            if let annotation = annotation as? MKAnnotation {
                mapView.deselectAnnotation(annotation, animated: false)
            }
        }
    }
    
    func onClickedPostDetailButton(_ postId: String) {
        let vc = PostDetailViewController.instance(postId: postId, isFavorite: isFavoritePost(postId: postId))
        vc.delegate = self
        navigateTo(vc)
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
        let cell = optionCollectionView.dequeueReusableCell(withReuseIdentifier: AddressCollectionViewCell.reusableIdentifier, for: indexPath) as! AddressCollectionViewCell
        let item = viewModel.options.value[indexPath.row]
        cell.config(content: item)
        let width = cell.contentLabel.intrinsicContentSize.width + 20
        return CGSize(width: width, height: 40)
    }
}
