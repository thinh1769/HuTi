//
//  SignInViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 28/03/2023.
//

import Foundation
import RxRelay
import RxSwift

class SignInViewModel: BaseViewModel {
    
    func signIn(phoneNumber: String, password: String) -> Observable<User> {
        return authService.signIn(phoneNumber: phoneNumber, password: password)
    }
}
