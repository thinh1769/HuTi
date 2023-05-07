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
    
    func sendOTP(email: String) -> Observable<User> {
        return authService.sendOTP(email: email)
    }
    
    func sendOTPResetPassword(email: String) -> Observable<User> {
        return authService.sendOTPResetPassword(email: email)
    }
}
