//
//  ConfirmPasswordViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 30/03/2023.
//

import Foundation
import RxRelay
import RxSwift

class ConfirmPasswordViewModel: BaseViewModel {
    var otp = ""
    var phoneNumber = ""
    var isRegister = true
    
    func register(password: String) -> Observable<User> {
        return authService.register(phoneNumber: phoneNumber, otp: otp, password: password)
    }
    
    func resetPassword(password: String) -> Observable<User> {
        return authService.resetPassword(phoneNumber: phoneNumber, otp: otp, password: password)
    }
}
