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
import CoreLocation

class FilterResultViewController: BaseViewController {
    
    @IBOutlet private weak var optionView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var optionCollectionView: UICollectionView!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var mapButton: UIButton!
    @IBOutlet private weak var filterResultTableView: UITableView!
    @IBOutlet private weak var mapView: MKMapView!
    
    var viewModel = FilterResultViewModel()
    private var locationManager = CLLocationManager()
    private let provinceSpan = MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
    private let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        loadData()
        mapView.delegate = self
        mapView.isHidden = true
        optionView.isHidden = true
        titleLabel.text = viewModel.mainTabBarItemTitle
        setupCollectionView()
        setupTableView()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
            self.pinRealEstateLocation()
        }.disposed(by: viewModel.bag)
    }
    
    private func getListProjects() {
        viewModel.getListProjects().subscribe { [weak self] projects in
            guard let self = self else { return }
            self.viewModel.project.accept(projects)
        }.disposed(by: viewModel.bag)
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
                self.viewModel.getImage(remoteName: element.thumbnail) { thumbnail in
                    DispatchQueue.main.async {
                        cell.loadThumbnail(thumbnail: thumbnail)
                    }
                }
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
                self.viewModel.getImage(remoteName: element.images[0]) { thumbnail in
                    DispatchQueue.main.async {
                        cell.loadThumbnail(thumbnail: thumbnail)
                    }
                }
                cell.config(project: element)
            }.disposed(by: viewModel.bag)
        
        filterResultTableView.rx
            .modelSelected(Project.self)
            .subscribe { [weak self] element in
                guard let self = self else { return }
                let vc = ProjectDetailViewController.instance(project: element)
                self.navigateTo(vc)
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
        optionView.isHidden = false
    }
    
    func didTapResetButton() {
        viewModel.optionsList = []
        viewModel.options.accept(viewModel.optionsList)
        if viewModel.tabBarItemTitle == TabBarItemTitle.project {
            getListProjects()
        } else {
            getListPosts()
        }
        
        optionView.isHidden = true
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
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        guard let tempId = annotation.title,
              let id = tempId
        else { return }
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
        detailView.loadData(viewModel.post.value[viewModel.getIndexOfSelectedPost(postId: id)])
        detailView.tag = SubviewTag.detailView.rawValue

        if detailView.superview == nil {
            self.view.addSubview(detailView)
            
            detailView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                detailView.heightAnchor.constraint(equalToConstant: 215)
            ])
        }
    }
}

extension FilterResultViewController: PostDetailViewControllerDelegate {
    func didTappedLikeButton() {
        filterResultTableView.reloadData()
    }
}

extension FilterResultViewController: DetailPopupViewDelegate {
    func onClickedEditLocationButton(_ postId: String) {
        let vc = PostDetailViewController.instance(postId: postId, isFavorite: isFavoritePost(postId: postId))
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
