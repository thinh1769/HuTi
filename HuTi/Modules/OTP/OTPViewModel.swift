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
    var phoneNumber = ""
    var isRegister = true
    
    func confirmOTP(otp: String) -> Observable<User> {
        return authService.confirmOTP(phoneNumber: phoneNumber, otp: otp)
    }
}
