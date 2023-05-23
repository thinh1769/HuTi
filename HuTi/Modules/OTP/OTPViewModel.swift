//
//  OTPViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 30/03/2023.
//

import Foundation
import RxRelay
import RxSwift

class OTPViewModel: BaseViewModel {
    var email = ""
    var type = AuthenType.register
    
    func confirmOTP(otp: String) -> Observable<User> {
        return authService.confirmOTP(email: email, otp: otp)
    }
    
    func updateEmail() -> Observable<User> {
        let userUpdated = User(email: email)
        return authService.updateInfo(user: userUpdated)
    }
    
    func sendOTP(email: String) -> Observable<User> {
        return authService.sendOTP(email: email)
    }
    
    func sendOTPResetPassword(email: String) -> Observable<User> {
        return authService.sendOTPResetPassword(email: email)
    }
}
