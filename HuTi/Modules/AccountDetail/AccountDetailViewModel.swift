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
    var selectedGender = -1
    var userUpdated = User(phoneNumber: UserDefaults.userInfo?.phoneNumber ?? "")
    
    func pickItem(pickerTag: Int) -> String? {
        switch pickerTag{
        case PickerTag.gender:
            if gender.value.count > 0 && selectedGender >= 0 {
                return gender.value[selectedGender]
            } else if selectedGender == -1 {
                selectedGender = 0
                return gender.value[0]
            } else {
                return ""
            }
        default:
            return ""
        }
    }
    
    func isInfoUpdated() -> Bool {
        if  name == UserDefaults.userInfo?.name ?? "" &&
            dob == UserDefaults.userInfo?.dateOfBirth ?? "" &&
            !checkGenderPickerIsChanged() &&
            identityCard == UserDefaults.userInfo?.identityCardNumber ?? "" &&
            email == UserDefaults.userInfo?.email ?? "" {
            return false
        } else {
            return true
        }
    }
    
    func checkGenderPickerIsChanged() -> Bool {
        if selectedGender == -1 {
            return false
        } else if UserDefaults.userInfo?.gender ?? "" == gender.value[selectedGender] {
            return false
        } else {
            return true
        }
    }
    
    func updateInfo() -> Observable<User> {
        var genderUpdated = UserDefaults.userInfo?.gender ?? ""
        if checkGenderPickerIsChanged() {
            genderUpdated = gender.value[selectedGender]
        }
        userUpdated = User(name: name, phoneNumber: phone, email: email, dateOfBirth: dob, gender: genderUpdated, identityCardNumber: identityCard)
        return authService.updateInfo(user: userUpdated)
    }
}
