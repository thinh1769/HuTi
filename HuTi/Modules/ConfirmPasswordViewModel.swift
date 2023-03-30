//
//  ConfirmPasswordViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 30/03/2023.
//

import Foundation
import RxRelay
import RxSwift

class ConfirmPasswordViewModel {
    let bag = DisposeBag()
    let authService = AuthService()
    var otp = ""
    var phoneNumber = ""
    
    func register(password: String) -> Observable<User> {
        return authService.register(phoneNumber: phoneNumber, otp: otp, password: password)
    }
}
