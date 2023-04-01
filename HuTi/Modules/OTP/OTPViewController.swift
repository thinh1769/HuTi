//
//  OTPViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 17/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class OTPViewController: BaseViewController {

    @IBOutlet private weak var OTPTextField: UITextField!
    @IBOutlet private weak var OTPView: UIView!
    
    var arrayOTPLabel: [UILabel] = []
    let OTPStackView = UIStackView()
    let numberOfOTP = 6
    var viewModel = OTPViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        OTPTextField.becomeFirstResponder()
        OTPTextField.tintColor = .clear
        OTPTextField.textColor = .clear
        OTPTextField.delegate = self
        isTouchDismissKeyboardEnabled = true
        setupOTPStackView()
        
        OTPTextField.rx.controlEvent([.editingChanged]).subscribe { [weak self] _ in
            guard let self = self,
                  let otp = self.OTPTextField.text
            else { return }
            if otp.count == 6 {
                self.confirmOTP()
            }
        }.disposed(by: viewModel.bag)
    }
    
    @IBAction func onClickedContinueBtn(_ sender: UIButton) {
        confirmOTP()
    }
    
    private func confirmOTP() {
        guard let otp = OTPTextField.text,
              otp.count == 6
        else { return }
        showLoading()
        viewModel.confirmOTP(otp: otp).subscribe { _ in
        } onError: { error in
            self.hideLoading()
            print("---- Error: \(error.localizedDescription)----")
        } onCompleted: { [weak self] in
            guard let self = self else { return }
            let vc = ConfirmPasswordViewController.instance(phoneNumber: self.viewModel.phoneNumber, otp: otp)
            self.hideLoading()
            self.navigateTo(vc)
        }.disposed(by: viewModel.bag)
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    
    private func setupOTPStackView() {
        OTPStackView.axis = .horizontal
        OTPStackView.distribution = .fillEqually
        OTPStackView.alignment = .center
        OTPStackView.spacing = 5
        
        for _ in 0 ... (numberOfOTP - 1) {
            let OTPLabel = createOTPLabel()
            OTPStackView.addArrangedSubview(OTPLabel)
            arrayOTPLabel.append(OTPLabel)
        }
        
        OTPStackView.translatesAutoresizingMaskIntoConstraints = false
        OTPView.addSubview(OTPStackView)
        OTPView.sendSubviewToBack(OTPStackView)
        
        OTPStackView.leadingAnchor.constraint(equalTo: OTPTextField.leadingAnchor).isActive = true
        OTPStackView.trailingAnchor.constraint(equalTo: OTPTextField.trailingAnchor).isActive = true
        OTPStackView.topAnchor.constraint(equalTo: OTPTextField.topAnchor).isActive = true
    }
    
    private func createOTPLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor(named: ColorName.otpBackground)
        label.widthAnchor.constraint(equalToConstant: OTPTextField.bounds.width / CGFloat(numberOfOTP)).isActive = true
        label.heightAnchor.constraint(equalToConstant: 85).isActive = true
        label.layer.cornerRadius = 8
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 50)
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }
}

extension OTPViewController {
    class func instance(phoneNumber: String) -> OTPViewController {
        let controller = OTPViewController(nibName: ClassNibName.OTPViewController, bundle: Bundle.main)
        controller.viewModel.phoneNumber = phoneNumber
        return controller
    }
}

// MARK: - UITextFieldDelegate.
extension OTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            if arrayOTPLabel[numberOfOTP - 1].text != nil {
                return false
            } else {
                for i in 0...numberOfOTP - 1 {
                    if arrayOTPLabel[i].text == nil {
                        arrayOTPLabel[i].text = string
                        return true
                    }
                }
            }
        }
        if string == "" {
            for i in (0...numberOfOTP - 1).reversed() {
                if arrayOTPLabel[i].text != nil {
                    arrayOTPLabel[i].text = nil
                    return true
                }
            }
        }
        OTPTextField.text = ""
        return false
    }
}
