//
//  SignUpvViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 28/03/2023.
//

import Foundation
import RxSwift
import RxRelay

class SignUpViewModel {
    let authService = AuthService()
    let bag = DisposeBag()
    
    func sendOTP(phoneNumber: String) -> Observable<User> {
        return authService.sendOTP(phoneNumber: phoneNumber)
    }
}
