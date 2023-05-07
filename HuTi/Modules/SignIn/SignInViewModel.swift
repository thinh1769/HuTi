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
    
    func signIn(email: String, password: String) -> Observable<User> {
        return authService.signIn(email: email, password: password)
    }
}
