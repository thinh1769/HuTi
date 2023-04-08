//
//  PostDetailViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 16/03/2023.
//

import UIKit
import MapKit
import CoreLocation

class PostDetailViewController: BaseViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var projectInfoView: UIView!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var acreageLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var legelLabel: UILabel!
    @IBOutlet weak var funitureView: UIStackView!
    @IBOutlet weak var funitureLabel: UILabel!
    @IBOutlet weak var bedroomView: UIStackView!
    @IBOutlet weak var bedroomLabel: UILabel!
    @IBOutlet weak var bathroomView: UIStackView!
    @IBOutlet weak var bathroomLabel: UILabel!
    @IBOutlet weak var floorView: UIStackView!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var houseDirectionLabel: UILabel!
    @IBOutlet weak var balconyView: UIStackView!
    @IBOutlet weak var balconyLabel: UILabel!
    @IBOutlet weak var wayInView: UIStackView!
    @IBOutlet weak var wayInLabel: UILabel!
    @IBOutlet weak var facadeView: UIStackView!
    @IBOutlet weak var facadeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var investorLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    lazy var viewModel = PostDetailViewModel()
    var isLiked = false
    private var locationManager = CLLocationManager()
    private let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupImageCollectionView()
        projectInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProjectDetailView)))
    }

    private func setupUI() {
        viewModel.getPostDetail(postId: viewModel.postId).subscribe { [weak self] postDetail in
            guard let self = self else { return }
            self.viewModel.postDetail = postDetail
            self.loadPostDetail()
            self.viewModel.images.accept(postDetail.images)
        }.disposed(by: viewModel.bag)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func loadPostDetail() {
        let post = viewModel.postDetail
        titleLabel.text = post?.title
        addressLabel.text = "\(post?.address ?? "") ,\(post?.wardName ?? ""), \(post?.districtName ?? ""), \(post?.provinceName ?? "")"
        acreageLabel.text = "\(post?.acreage ?? 0) m2"
        priceLabel.text = "\(post?.price ?? 0) VNĐ"
        legelLabel.text = post?.legal
        funitureLabel.text = post?.funiture
        bedroomLabel.text = "\(post?.bedroom ?? 0)"
        bathroomLabel.text = "\(post?.bathroom ?? 0)"
        floorLabel.text = "\(post?.floor ?? 0)"
        houseDirectionLabel.text = post?.houseDirection
        balconyLabel.text = post?.balconyDirection
        wayInLabel.text = "\(post?.wayIn ?? 0) m"
        facadeLabel.text = "\(post?.facade ?? 0) m"
        descriptionLabel.text = post?.description
        self.pinRealEstateLocation()
        
        unhiddenAllView()
        switch viewModel.postDetail?.realEstateType {
        case RealEstateType.apartment:
            self.floorView.isHidden = true
            self.wayInView.isHidden = true
            self.facadeView.isHidden = true
        case RealEstateType.projectLand:
            self.funitureView.isHidden = true
            self.bedroomView.isHidden = true
            self.bathroomView.isHidden = true
            self.floorView.isHidden = true
            self.balconyView.isHidden = true
        case RealEstateType.land:
            self.funitureView.isHidden = true
            self.bedroomView.isHidden = true
            self.bathroomView.isHidden = true
            self.floorView.isHidden = true
            self.balconyView.isHidden = true
        case RealEstateType.codontel:
            self.floorView.isHidden = true
            self.wayInView.isHidden = true
            self.facadeView.isHidden = true
        case RealEstateType.wareHouseFactory:
            self.bedroomView.isHidden = true
            self.floorView.isHidden = true
            self.balconyView.isHidden = true
        case RealEstateType.office:
            self.floorView.isHidden = true
        case RealEstateType.shopKiosk:
            self.bedroomView.isHidden = true
        default:
            return
        }
    }
  
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    
    @IBAction func onClickedLikeButton(_ sender: UIButton) {
        if !isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = UIColor(named: ColorName.redStatusText)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = UIColor(named: ColorName.gray)
        }
        isLiked = !isLiked
    }
    
    @IBAction func onClickedRealEstateLocationButton(_ sender: UIButton) {
        pinRealEstateLocation()
    }
    
    
    @objc private func goToProjectDetailView() {
        let vc = ProjectDetailViewController()
        navigateTo(vc)
    }
    
    private func setupImageCollectionView() {
        imageCollectionView.register(NewPostImageCell.nib, forCellWithReuseIdentifier: NewPostImageCell.reusableIdentifier)
        
        viewModel.images.asObservable()
            .bind(to: imageCollectionView.rx.items(cellIdentifier: NewPostImageCell.reusableIdentifier, cellType: NewPostImageCell.self)) { (index, element, cell) in
                self.viewModel.getImage(remoteName: element) { image in
                    DispatchQueue.main.async {
                        cell.config(image: image)
                    }
                }
            }.disposed(by: viewModel.bag)
        
        imageCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func unhiddenAllView() {
        funitureView.isHidden = false
        bedroomView.isHidden = false
        bathroomView.isHidden = false
        floorView.isHidden = false
        balconyView.isHidden = false
        wayInView.isHidden = false
        facadeView.isHidden = false
    }
}

extension PostDetailViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    private func moveCameraToLocation(_ lat: Double, _ long: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    private func pinRealEstateLocation() {
        guard let lat = viewModel.postDetail?.lat,
              let long = viewModel.postDetail?.long
        else { return }
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        moveCameraToLocation(lat, long)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}

extension PostDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollectionView.bounds.width / 2, height: imageCollectionView.bounds.height)
    }
}

extension PostDetailViewController {
    class func instance(postId: String) -> PostDetailViewController {
        let controller = PostDetailViewController(nibName: ClassNibName.PostDetailViewController, bundle: Bundle.main)
        controller.viewModel.postId = postId
        return controller
    }
}
