//
//  OTPViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 30/03/2023.
//

import Foundation
import RxRelay
import RxSwift

class OTPViewModel {
    let bag = DisposeBag()
    let authService = AuthService()
    var phoneNumber = ""
    
    func confirmOTP(otp: String) -> Observable<User> {
        return authService.confirmOTP(phoneNumber: phoneNumber, otp: otp)
    }
}
