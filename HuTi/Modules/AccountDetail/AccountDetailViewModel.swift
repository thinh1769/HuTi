//
//  AccountDetailViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 30/03/2023.
//

import Foundation
import RxSwift
import RxRelay

class AccountDetailViewModel {
    let bag = DisposeBag()
    let authService = AuthService()
    var name = UserDefaults.userInfo?.name ?? ""
    var phone = UserDefaults.userInfo?.phoneNumber ?? ""
    var dob = UserDefaults.userInfo?.dateOfBirth ?? ""
    var gender = BehaviorRelay<[String]>(value: [])
    var identityCard = UserDefaults.userInfo?.identityCardNumber ?? ""
    var email = UserDefaults.userInfo?.email ?? ""
    var isEditButtonClicked = false
    var selectedGender = 0
    
    func pickItem(pickerTag: Int) -> String? {
        switch pickerTag{
        case PickerTag.gender:
            if gender.value.count > 0 {
                return gender.value[selectedGender]
            } else {
                return ""
            }
        default:
            return ""
        }
    }
    
    func isInfoUpdated() -> Bool {
        if name == UserDefaults.userInfo?.name ?? "" &&
            dob == UserDefaults.userInfo?.dateOfBirth ?? "" &&
            gender.value[selectedGender] == UserDefaults.userInfo?.gender ?? nil &&
            identityCard == UserDefaults.userInfo?.identityCardNumber ?? "" &&
            email == UserDefaults.userInfo?.email ?? "" {
            return false
        } else {
            return true
        }
    }
    
    func updateInfo() -> Observable<User> {
        return authService.updateInfo(user: User(name: name, phoneNumber: phone, email: email, dateOfBirth: dob, gender: gender.value[selectedGender], identityCardNumber: identityCard))
    }
}
