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

class NewPostViewController: BaseViewController {

    @IBOutlet weak var sellCheckmarkImage: UIImageView!
    @IBOutlet weak var forRentCheckmarkImage: UIImageView!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var wardTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var legalTextField: UITextField!
    @IBOutlet weak var funitureTextField: UITextField!
    @IBOutlet weak var houseDirectionTextField: UITextField!
    @IBOutlet weak var balconyDirectionTextField: UITextField!
    @IBOutlet weak var sellView: UIView!
    @IBOutlet weak var forRentView: UIView!
    
    let typePicker = UIPickerView()
    let cityPicker = UIPickerView()
    let districtPicker = UIPickerView()
    let wardPicker = UIPickerView()
    let projectPicker = UIPickerView()
    let legalPicker = UIPickerView()
    let funiturePicker = UIPickerView()
    let houseDirectionPicker = UIPickerView()
    let balconyDirectionPicker = UIPickerView()
    
    var viewModel = NewPostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupPickerView()
        sellView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickedSellView)))
        forRentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickedForRentView)))
    }
    
    private func setupPickerView() {
        setupTypePickerView()
        setupCityPickerView()
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
    
    private func setupCityPickerView() {
        cityTextField.inputView = cityPicker
        cityTextField.tintColor = .clear
        cityPicker.tag = PickerTag.city
        cityTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.city)

        viewModel.city.accept(TypeRealEstate.sell)

        viewModel.city.subscribe(on: MainScheduler.instance)
            .bind(to: cityPicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        cityPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedCity = row
        }.disposed(by: viewModel.bag)
    }

    private func setupDistrictPickerView() {
        districtTextField.inputView = districtPicker
        districtTextField.tintColor = .clear
        districtPicker.tag = PickerTag.district
        districtTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.district)

        viewModel.district.accept(TypeRealEstate.sell)

        viewModel.district.subscribe(on: MainScheduler.instance)
            .bind(to: districtPicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        districtPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedDistrict = row
        }.disposed(by: viewModel.bag)
    }

    private func setupWardPickerView() {
        wardTextField.inputView = wardPicker
        wardTextField.tintColor = .clear
        wardPicker.tag = PickerTag.ward
        wardTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.ward)

        viewModel.ward.accept(TypeRealEstate.sell)
        

        viewModel.ward.subscribe(on: MainScheduler.instance)
            .bind(to: wardPicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        wardPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedWard = row
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

        viewModel.legal.accept(TypeRealEstate.sell)

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
        
        viewModel.funiture.accept(TypeRealEstate.sell)

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

        viewModel.houseDirection.accept(TypeRealEstate.sell)

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

        viewModel.balconyDirection.accept(TypeRealEstate.sell)

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
        case PickerTag.city:
            cityTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        case PickerTag.district:
            districtTextField.text = viewModel.pickItem(pickerTag: sender.tag)
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
