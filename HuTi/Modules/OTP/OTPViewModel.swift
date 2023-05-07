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
    var type = 0
    
    func confirmOTP(otp: String) -> Observable<User> {
        return authService.confirmOTP(email: email, otp: otp)
    }
}
