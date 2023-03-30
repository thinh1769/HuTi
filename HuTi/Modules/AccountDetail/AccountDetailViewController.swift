//
//  AccountDetailViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 10/03/2023.
//

import UIKit

class AccountDetailViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var identityCardTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var editButton: UIButton!
    
    var viewModel = AccountDetailViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = UserDefaults.userInfo?.name ?? ""
        nameTextField.text = UserDefaults.userInfo?.name ?? ""
        dobTextField.text = UserDefaults.userInfo?.dateOfBirth ?? ""
        genderTextField.text = "\(UserDefaults.userInfo?.gender)"
        identityCardTextField.text = UserDefaults.userInfo?.identityCardNumber ?? ""
        phoneTextField.text = UserDefaults.userInfo?.phoneNumber ?? ""
        emailTextField.text = UserDefaults.userInfo?.email ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        isTouchDismissKeyboardEnabled = true
    }

    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
}
