//
//  AccountViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 19/03/2023.
//

import Foundation
import RxRelay
import RxSwift

class AccountViewModel: BaseViewModel {
    func checkUpdateInfo() -> Bool {
        guard let name = UserDefaults.userInfo?.name,
              name != "",
              let dateOfBirth = UserDefaults.userInfo?.dateOfBirth,
              dateOfBirth != "",
              let gender = UserDefaults.userInfo?.gender,
              gender != "",
              let identityCardNumber = UserDefaults.userInfo?.identityCardNumber,
              identityCardNumber != "",
              let email = UserDefaults.userInfo?.email,
              email != ""
        else { return false }
        return true
    }
}
