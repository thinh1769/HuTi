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
    var name = ""
    var dob = ""
    var gender = true
    var identityCard = ""
    var email = ""
    
    func updateInfo() -> Observable<User> {
        return authService.updateInfo(user: User(phoneNumber: UserDefaults.userInfo?.phoneNumber ?? ""))
    }
}
