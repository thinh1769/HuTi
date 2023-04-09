//
//  SignUpvViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 28/03/2023.
//

import Foundation
import RxSwift
import RxRelay

class SignUpViewModel: BaseViewModel {
    var isRegister = true
    
    func sendOTP(phoneNumber: String) -> Observable<User> {
        return authService.sendOTP(phoneNumber: phoneNumber)
    }
    
    func sendOTPResetPassword(phoneNumber: String) -> Observable<User> {
        return authService.sendOTPResetPassword(phoneNumber: phoneNumber)
    }
}
