//
//  NewPostViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 14/03/2023.
//

import UIKit

class NewPostViewController: BaseViewController {

    @IBOutlet weak var isSelectedSellBtn: UIButton!
    @IBOutlet weak var isSelectedForRentBtn: UIButton!
    @IBOutlet weak var typeTextField: UITextField!
    
    let typePicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        
    }
    
    @IBAction func onClickedBackBtn(_ sender: UIButton) {
        backToPreviousView()
    }
    @IBAction func onClickedSellBtn(_ sender: UIButton) {
        isSelectedSellBtn.setImage(UIImage(systemName: ImageName.checkmarkFill), for: .normal)
        isSelectedForRentBtn.setImage(UIImage(systemName: ImageName.circle), for: .normal)
    }
    
    @IBAction func onClickedForRentBtn(_ sender: UIButton) {
        isSelectedSellBtn.setImage(UIImage(systemName: ImageName.circle), for: .normal)
        isSelectedForRentBtn.setImage(UIImage(systemName: ImageName.checkmarkFill), for: .normal)
    }
    
    private func setupPickerView() {
        typeTextField.attributedPlaceholder = NSAttributedString(string: TextFieldPlaceHolder.type, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3])
        typeTextField.inputView = typePicker
        typePicker.tintColor = .clear
        typePicker.tag = PickerTag.type
        typeTextField.inputAccessoryView = setupPickerToolBar(pickerTag: PickerTag.type)
        
//        viewModel.locationType.accept(CommonConstants.LOCATION_TYPE)
//
//        viewModel.locationType.subscribe(on: MainScheduler.instance)
//            .bind(to: locationTypePicker.rx.itemTitles) { (row, element) in
//                return element
//            }.disposed(by: viewModel.bag)
//
//        locationTypePicker.rx.itemSelected.bind { (row: Int, component: Int) in
//            self.viewModel.selectedLocationType = row
//        }.disposed(by: viewModel.bag)
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
    
    @objc private func donePicker() {
        
    }
    
    @objc private func cancelPicker() {
        view.window?.endEditing(true)
    }
}
