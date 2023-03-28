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
    
    func register(phoneNumber: String) -> Observable<User> {
        return authService.register(phoneNumber: phoneNumber)
    }
    
//    func register(phoneNumber: String, password: String, name: String) -> Observable<UserInfo> {
//        let user = UserInfo(phoneNumber: phoneNumber, password: password, name: name)
//        return service.register(user: user)
//    }
}
