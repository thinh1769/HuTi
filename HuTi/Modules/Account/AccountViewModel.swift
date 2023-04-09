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
        if UserDefaults.userInfo?.name != nil ||
           UserDefaults.userInfo?.dateOfBirth != nil ||
           UserDefaults.userInfo?.gender != nil ||
           UserDefaults.userInfo?.identityCardNumber != nil ||
           UserDefaults.userInfo?.email != nil
        {
            return false
        } else {
            return true 
        }
    }
}
