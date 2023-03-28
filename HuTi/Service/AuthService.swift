//
//  AuthService.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 28/03/2023.
//

import Foundation
import Alamofire
import RxSwift
import Security

class AuthService: BaseService {
    func signIn(phoneNumber: String, password: String) -> Observable<User> {
        let params = ["phoneNumber" : phoneNumber, "password": password]
        return authRequest(api: APIConstants.signIn, method: .post, parameters: params)
    }
    
    func register(phoneNumber: String) -> Observable<User> {
        return authRequest(api: APIConstants.register, method: .post, parameters: phoneNumber)
    }
    
//    func logOut() -> Observable<String> {
//        return request(api: .logout)
//    }
}
