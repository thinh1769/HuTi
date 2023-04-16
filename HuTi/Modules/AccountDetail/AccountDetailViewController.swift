//
//  AccountDetailViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 10/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class AccountDetailViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var identityCardTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var editGenderIcon: UIImageView!
    @IBOutlet weak var editDobIcon: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    let genderPicker = UIPickerView()
    let dobPicker = UIDatePicker()
    var viewModel = AccountDetailViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = UserDefaults.userInfo?.name ?? ""
        nameTextField.text = UserDefaults.userInfo?.name ?? ""
        dobTextField.text = UserDefaults.userInfo?.dateOfBirth ?? ""
        genderTextField.text = UserDefaults.userInfo?.gender ?? ""
        identityCardTextField.text = UserDefaults.userInfo?.identityCardNumber ?? ""
        phoneTextField.text = UserDefaults.userInfo?.phoneNumber ?? ""
        emailTextField.text = UserDefaults.userInfo?.email ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGenderPickerView()
        setupDobPickerView()
    }
    
    private func setupUI() {
        changeTextFieldStatus(false)
        phoneTextField.isUserInteractionEnabled = false
        isTouchDismissKeyboardEnabled = true
    }

    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    
    @IBAction func onClickedEditButton(_ sender: UIButton) {
        if !viewModel.isEditButtonClicked {
            editButton.setImage(UIImage(named: ImageName.save), for: .normal)
            changeTextFieldStatus(true)
        } else {
            editButton.setImage(UIImage(named: ImageName.edit), for: .normal)
            changeTextFieldStatus(false)
            updateUserInfoViewModel()
            if viewModel.isInfoUpdated() {
                showLoading()
                viewModel.updateInfo().subscribe { [weak self] _ in
                    guard let self = self else { return }
                    UserDefaults.userInfo = self.viewModel.userUpdated
                    self.nameLabel.text = UserDefaults.userInfo?.name ?? ""
                    self.hideLoading()
                    self.showAlert(title: Alert.updatedAccountSuccessfully)
                }.disposed(by: viewModel.bag)
            }
        }
        viewModel.isEditButtonClicked = !viewModel.isEditButtonClicked
    }
    
    private func changeTextFieldStatus(_ status: Bool) {
        nameTextField.isUserInteractionEnabled = status
        dobTextField.isUserInteractionEnabled = status
        genderTextField.isUserInteractionEnabled = status
        identityCardTextField.isUserInteractionEnabled = status
        emailTextField.isUserInteractionEnabled = status
        editDobIcon.isHidden = !status
        editGenderIcon.isHidden = !status
    }
    
    private func updateUserInfoViewModel() {
        viewModel.name = nameTextField.text ?? ""
        viewModel.dob = dobTextField.text ?? ""
        viewModel.identityCard = identityCardTextField.text ?? ""
        viewModel.email = emailTextField.text ?? ""
    }
}

extension AccountDetailViewController {
    private func setupGenderPickerView() {
        genderTextField.inputView = genderPicker
        genderTextField.tintColor = .clear
        genderPicker.tag = PickerTag.gender
        genderTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.gender)

        viewModel.gender.accept(PickerData.gender)

        viewModel.gender.subscribe(on: MainScheduler.instance)
            .bind(to: genderPicker.rx.itemTitles) { (row, element) in
                return element
            }.disposed(by: viewModel.bag)

        genderPicker.rx.itemSelected.bind { (row: Int, component: Int) in
            self.viewModel.selectedGender = row
        }.disposed(by: viewModel.bag)
    }
    
    private func setupDobPickerView() {
        dobTextField.inputView = dobPicker
        dobTextField.tintColor = .clear
        dobPicker.tag = PickerTag.dob
        dobPicker.datePickerMode = .date
        dobPicker.preferredDatePickerStyle = .wheels
        dobTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.dob)
    }
    
    private func setupPickerToolBar(pickerTag: Int) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.backgroundColor = .clear
        toolBar.sizeToFit()
       
        var doneButton = UIBarButtonItem(title: CommonConstants.done, style: .done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: CommonConstants.cancel, style: .plain, target: self, action: #selector(self.cancelPicker))
        
        if pickerTag == PickerTag.dob {
            doneButton = UIBarButtonItem(title: CommonConstants.done, style: .done, target: self, action: #selector(self.doneDobPicker))
        }
        
        cancelButton.tag = pickerTag
        doneButton.tag = pickerTag
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc private func doneDobPicker() {
        dobTextField.text = DateFormatter.instance(formatString: CommonConstants.DATE_FORMAT).string(from: dobPicker.date)
        view.endEditing(true)
    }
    
    @objc private func donePicker(sender: UIBarButtonItem) {
        switch sender.tag {
        case PickerTag.gender:
            genderTextField.text = viewModel.pickItem(pickerTag: sender.tag)
        default:
            return
        }
        view.endEditing(true)
    }
    
    @objc private func cancelPicker() {
        view.window?.endEditing(true)
    }
}
