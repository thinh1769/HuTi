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
        if UserDefaults.userInfo?.name != "",
           UserDefaults.userInfo?.dateOfBirth != "",
           UserDefaults.userInfo?.gender != "",
           UserDefaults.userInfo?.identityCardNumber != "",
           UserDefaults.userInfo?.email != ""
        {
            return true
        } else {
            return false
        }
    }
}
