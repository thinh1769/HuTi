//
//  NewPostViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 14/03/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import MapKit
import CoreLocation

class NewPostViewController: BaseViewController {
    
    @IBOutlet weak var sellCheckmarkImage: UIImageView!
    @IBOutlet weak var forRentCheckmarkImage: UIImageView!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var provinceTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var wardTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var legalTextField: UITextField!
    @IBOutlet weak var funitureTextField: UITextField!
    @IBOutlet weak var houseDirectionTextField: UITextField!
    @IBOutlet weak var balconyDirectionTextField: UITextField!
    @IBOutlet weak var sellView: UIView!
    @IBOutlet weak var forRentView: UIView!
    @IBOutlet weak var editLocationBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var decreaseBedroomBtn: UIButton!
    @IBOutlet weak var bedroomNumberLabel: UILabel!
    @IBOutlet weak var increaseBedroomBtn: UIButton!
    @IBOutlet weak var decreaseBathroomBtn: UIButton!
    @IBOutlet weak var bathroomNumberLabel: UILabel!
    @IBOutlet weak var increaseBathroomBtn: UIButton!
    @IBOutlet weak var decreaseFloorBtn: UIButton!
    @IBOutlet weak var increaseFloorBtn: UIButton!
    @IBOutlet weak var floorNumberLabel: UILabel!
    
    let typePicker = UIPickerView()
    let provincePicker = UIPickerView()
    let districtPicker = UIPickerView()
    let wardPicker = UIPickerView()
    let projectPicker = UIPickerView()
    let legalPicker = UIPickerView()
    let funiturePicker = UIPickerView()
    let houseDirectionPicker = UIPickerView()
    let balconyDirectionPicker = UIPickerView()
    
    var viewModel = NewPostViewModel()
    private var locationManager = CLLocationManager()
    private let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupPickerView()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.isUserInteractionEnabled = false
        
        sellView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickedSellView)))
        forRentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickedForRentView)))
        
        provinceTextField.rx.controlEvent([.editingDidEnd,.valueChanged])
            .subscribe { [weak self] _ in
            guard let self = self,
                  let text = self.provinceTextField.text
                else { return }
            if text.count > 0 {
                self.moveCameraToLocation(21.0031177, 105.8201408)
            }
        }.disposed(by: viewModel.bag)
    
    }
    
    private func setupPickerView() {
        setupTypePickerView()
        setupProvincePickerView()
        setupDistrictPickerView()
        setupWardPickerView()
        setupProjectPickerView()
        setupLegalPickerView()
        setupFuniturePickerView()
        setupHouseDirectionPickerView()
        setupBalconyDirectionPickerView()
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    @objc private func onClickedSellView() {
        if !viewModel.isSelectedSell {
            chooseSell(true)
        }
    }
    
    @objc private func onClickedForRentView() {
        if viewModel.isSelectedSell {
            chooseSell(false)
        }
    }
    
    @IBAction func onClickedEditLocationBtn(_ sender: UIButton) {
        if !viewModel.isEditBtnClicked {
            editLocationBtn.setTitle(CommonConstants.done, for: .normal)
            mapView.isUserInteractionEnabled = true
        } else {
            editLocationBtn.setTitle(CommonConstants.edit, for: .normal)
            mapView.isUserInteractionEnabled = false
        }
        viewModel.isEditBtnClicked = !viewModel.isEditBtnClicked
    }
    private func chooseSell(_ isChooseSell: Bool) {
        viewModel.isSelectedSell = isChooseSell
        typeTextField.text = ""
        viewModel.selectedType = 0
        if isChooseSell {
            sellCheckmarkImage.image = UIImage(systemName: ImageName.checkmarkFill)
            forRentCheckmarkImage.image = UIImage(systemName: ImageName.circle)
            viewModel.typeRealEstate.accept(TypeRealEstate.sell)
        } else {
            sellCheckmarkImage.image = UIImage(systemName: ImageName.circle)
            forRentCheckmarkImage.image = UIImage(systemName: ImageName.checkmarkFill)
            viewModel.typeRealEstate.accept(TypeRealEstate.forRent)
        }
    }
    @IBAction func onClickedDecreaseBedroomBtn(_ sender: UIButton) {
        if let number = Int(bedroomNumberLabel.text ?? "") {
            if number > 0 {
                bedroomNumberLabel.text = "\(number - 1)"
            }
        }
    }
    
    @IBAction func onClickedIncreaseBedroomBtn(_ sender: UIButton) {
        if let number = Int(bedroomNumberLabel.text ?? "") {
            bedroomNumberLabel.text = "\(number + 1)"
        }
    }
    
    @IBAction func onClickedDecreaseBathroomBtn(_ sender: UIButton) {
        if let number = Int(bathroomNumberLabel.text ?? "") {
            if number > 0 {
                bathroomNumberLabel.text = "\(number - 1)"
            }
        }
    }
    @IBAction func onClickedIncreaseBathroomBtn(_ sender: UIButton) {
        if let number = Int(bathroomNumberLabel.text ?? "") {
            bathroomNumberLabel.text = "\(number + 1)"
        }
    }
    @IBAction func onClickedDecreaseFloorBtn(_ sender: UIButton) {
        if let number = Int(floorNumberLabel.text ?? "") {
            if number > 0 {
                floorNumberLabel.text = "\(number - 1)"
            }
        }
    }
    @IBAction func onClickedIncreaseFloorBtn(_ sender: UIButton) {
        if let number = Int(floorNumberLabel.text ?? "") {
            floorNumberLabel.text = "\(number + 1)"
        }
    }
}

extension NewPostViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            locationManager.stopUpdatingLocation()
            moveCameraToLocation(location.coordinate.latitude, location.coordinate.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            mapView.showsUserLocation = true
//            pinUserLocation(coordinate)
        }
    }
    
    private func moveCameraToLocation(_ lat: Double, _ long: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: false)
    }
    
//    private func pinUserLocation(_ coordinate: CLLocationCoordinate2D) {
//        removeAnnotation(isRemoveAll: false)
//        let pin = MKPointAnnotation()
//        pin.title = LocationTitle.userLocation.rawValue
//        pin.coordinate = coordinate
//        mapView.addAnnotation(pin)
//    }
    
//    private func removeAnnotation(isRemoveAll: Bool) {
//        let annotations = mapView.annotations
//        for annotation in annotations {
//            if let annotation = annotation as? MKAnnotation {
//                if !isRemoveAll {
//                    guard let locationTitle = annotation.title else { return }
//                    if locationTitle == LocationTitle.userLocation.rawValue {
//                        mapView.removeAnnotation(annotation)
//                    }
//                } else {
//                    mapView.removeAnnotation(annotation)
//                }
//            }
//        }
//    }
    
//    private func pinLocation() {
//        for location in viewModel.location.value {
//            let coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
//            let pin = MKPointAnnotation()
//            pin.title = location.id
//            pin.coordinate = coordinate
//            mapView.addAnnotation(pin)
//        }
//    }
}

// MARK: - SetupPicker
extension NewPostViewController {
    private func setupTypePickerView() {
        typeTextField.inputView = typePicker
        typeTextField.tintColor = .clear
        typePicker.tag = PickerTag.type
        typeTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.type)
        
        viewModel.typeRealEstate.accept(TypeRealEstate.sell)

        viewModel.typeRealEstate.subscribe(on: MainScheduler.instance)
            .bind(to: typePicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        typePicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedType = row
        }.disposed(by: viewModel.bag)
    }
    
    private func setupProvincePickerView() {
        provinceTextField.inputView = provincePicker
        provinceTextField.tintColor = .clear
        provincePicker.tag = PickerTag.province
        provinceTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.province)

        viewModel.getAllProvinces().subscribe { [weak self] provinces in
            guard let self = self else { return }
            self.viewModel.province.accept(self.viewModel.parseProvincesArray(provinces: provinces))
        } onError: { _ in
        } onCompleted: {
        } .disposed(by: viewModel.bag)

        viewModel.province.subscribe(on: MainScheduler.instance)
            .bind(to: provincePicker.rx.itemTitles) { (row, element) in
                return element.name
            }.disposed(by: viewModel.bag)

        provincePicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedProvince = row
        }.disposed(by: viewModel.bag)
    }

    private func setupDistrictPickerView() {
        districtTextField.inputView = districtPicker
        districtTextField.tintColor = .clear
        districtPicker.tag = PickerTag.district
        districtTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.district)

        viewModel.district.subscribe(on: MainScheduler.instance)
            .bind(to: districtPicker.rx.itemTitles) { (row, element) in
                return element.name
            }.disposed(by: viewModel.bag)

        districtPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedDistrict = row
        }.disposed(by: viewModel.bag)
    }
    
    private func setupDistrictDataPicker() {
        districtTextField.text = ""
        wardTextField.text = ""
        
        viewModel.getDistrictsByProvinceId().subscribe { [weak self] districts in
            guard let self = self else { return }
            self.viewModel.district.accept(self.viewModel.parseDistrictsArray(districts: districts))
        } onError: { _ in
        } onCompleted: {
        }.disposed(by: viewModel.bag)
    }

    private func setupWardPickerView() {
        wardTextField.inputView = wardPicker
        wardTextField.tintColor = .clear
        wardPicker.tag = PickerTag.ward
        wardTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.ward)

        viewModel.ward.subscribe(on: MainScheduler.instance)
            .bind(to: wardPicker.rx.itemTitles) { (row, element) in
                return element.name
            }.disposed(by: viewModel.bag)

        wardPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedWard = row
        }.disposed(by: viewModel.bag)
    }

    private func setupWardDataPicker() {
        wardTextField.text = ""
        
        viewModel.getWardsByDistrictId().subscribe { [weak self] wards in
            guard let self = self else { return }
            self.viewModel.ward.accept(self.viewModel.parseWardsArray(wards: wards))
        } onError: { _ in
        } onCompleted: {
        }.disposed(by: viewModel.bag)
    }
    
    private func setupProjectPickerView() {
        projectTextField.inputView = projectPicker
        projectTextField.tintColor = .clear
        projectPicker.tag = PickerTag.project
        projectTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.project)

        viewModel.project.accept(TypeRealEstate.sell)

        viewModel.project.subscribe(on: MainScheduler.instance)
            .bind(to: projectPicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        projectPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedProject = row
        }.disposed(by: viewModel.bag)
    }

    private func setupLegalPickerView() {
        legalTextField.inputView = legalPicker
        legalTextField.tintColor = .clear
        legalPicker.tag = PickerTag.legal
        legalTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.legal)

        viewModel.legal.accept(PickerData.legal)

        viewModel.legal.subscribe(on: MainScheduler.instance)
            .bind(to: legalPicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        legalPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedLegal = row
        }.disposed(by: viewModel.bag)
    }

    private func setupFuniturePickerView() {
        funitureTextField.inputView = funiturePicker
        funitureTextField.tintColor = .clear
        funiturePicker.tag = PickerTag.funiture
        funitureTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.funiture)
        
        viewModel.funiture.accept(PickerData.funiture)

        viewModel.funiture.subscribe(on: MainScheduler.instance)
            .bind(to: funiturePicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        funiturePicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedFuniture = row
        }.disposed(by: viewModel.bag)
    }

    private func setupHouseDirectionPickerView() {
        houseDirectionTextField.inputView = houseDirectionPicker
        houseDirectionTextField.tintColor = .clear
        houseDirectionPicker.tag = PickerTag.houseDirection
        houseDirectionTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.houseDirection)

        viewModel.houseDirection.accept(PickerData.direction)

        viewModel.houseDirection.subscribe(on: MainScheduler.instance)
            .bind(to: houseDirectionPicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        houseDirectionPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedHouseDirection = row
        }.disposed(by: viewModel.bag)
    }

    private func setupBalconyDirectionPickerView() {
        balconyDirectionTextField.inputView = balconyDirectionPicker
        balconyDirectionTextField.tintColor = .clear
        balconyDirectionPicker.tag = PickerTag.balconyDirection
        balconyDirectionTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.balconyDirection)

        viewModel.balconyDirection.accept(PickerData.direction)

        viewModel.balconyDirection.subscribe(on: MainScheduler.instance)
            .bind(to: balconyDirectionPicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        balconyDirectionPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedBalconyDirection = row
        }.disposed(by: viewModel.bag)
    }
    
    private func setupPickerToolBar(pickerTag: Int) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.backgroundColor = .clear
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: CommonConstants.done, style: .done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: CommonConstants.cancel, style: .plain, target: self, action: #selector(self.cancelPicker))
        
        cancelButton.tag = pickerTag
        doneButton.tag = pickerTag
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc private func donePicker(sender: UIBarButtonItem) {
        switch sender.tag {
        case PickerTag.type:
            typeTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        case PickerTag.province:
            provinceTextField.text = viewModel.pickItem(pickerTag: sender.tag)
            setupDistrictDataPicker()
        case PickerTag.district:
            districtTextField.text = viewModel.pickItem(pickerTag: sender.tag)
            setupWardDataPicker()
        case PickerTag.ward:
            wardTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        case PickerTag.project:
            projectTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        case PickerTag.legal:
            legalTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        case PickerTag.funiture:
            funitureTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        case PickerTag.houseDirection:
            houseDirectionTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        case PickerTag.balconyDirection:
            balconyDirectionTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        default:
            return
        }
        view.endEditing(true)
    }
    
    @objc private func cancelPicker() {
        view.window?.endEditing(true)
    }
}
