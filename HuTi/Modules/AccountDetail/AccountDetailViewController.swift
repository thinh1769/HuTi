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
    @IBOutlet weak var editEmailButton: UIButton!
    
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
        self.mainTabBarController?.tabBar.isHidden = true
        changeTextFieldStatus(false)
        editButton.setImage(UIImage(named: ImageName.edit), for: .normal)
        viewModel.isEditButtonClicked = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGenderPickerView()
        setupDobPickerView()
    }
    
    private func setupUI() {
        emailTextField.isUserInteractionEnabled = false
        isTouchDismissKeyboardEnabled = true
        phoneTextField.delegate = self
        identityCardTextField.delegate = self
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
            if viewModel.isInfoUpdated() && validateForm() {
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
    
    private func validateForm() -> Bool {
        if let name = nameTextField.text,
           name == "HuTi User" || name == "" {
            showAlert(title: "Vui lòng nhập hoặc thay đổi họ tên")
            return false
        }
        
        if let identity = identityCardTextField.text,
           identity.count < 9 || identity.count == 10 || identity.count == 11 {
            showAlert(title: "Vui lòng nhập đầy đủ số CMND/CCCD")
            return false
        }
        
        if let phone = phoneTextField.text {
            if phone.count < 10 {
                showAlert(title: "Vui lòng nhập đầy đủ số điện thoại")
                return false
            }
            if phone.first != "0" {
                showAlert(title: "Số điện thoại phải bắt đầu bằng số 0")
                return false
            }
        }
        return true
    }
    
    private func changeTextFieldStatus(_ status: Bool) {
        nameTextField.isUserInteractionEnabled = status
        dobTextField.isUserInteractionEnabled = status
        genderTextField.isUserInteractionEnabled = status
        identityCardTextField.isUserInteractionEnabled = status
        phoneTextField.isUserInteractionEnabled = status
        editDobIcon.isHidden = !status
        editGenderIcon.isHidden = !status
        editEmailButton.isHidden = !status
    }
    
    private func updateUserInfoViewModel() {
        viewModel.name = nameTextField.text ?? ""
        viewModel.dob = dobTextField.text ?? ""
        viewModel.identityCard = identityCardTextField.text ?? ""
        viewModel.phone = phoneTextField.text ?? ""
    }
    
    @IBAction func didTapChangePasswordButton(_ sender: UIButton) {
        let vc = ConfirmPasswordViewController.instance(email: nil, otp: nil, type: AuthenType.changePassword)
        navigateTo(vc)
    }
    
    @IBAction func didTapChangeEmailButton(_ sender: UIButton) {
        let vc = SignUpViewController.instance(type: AuthenType.changeEmail)
        navigateTo(vc)
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
        dobPicker.minimumDate = Date().getMinimumDate()
        dobPicker.maximumDate = Date().getMaximumDate()
        
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

extension AccountDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if textField == phoneTextField {
            return newLength <= 10
        } else {
            return newLength <= 12
        }
    }
}
