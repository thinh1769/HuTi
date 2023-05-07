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
    func signIn(email: String, password: String) -> Observable<User> {
        let params: [String: Any] = ["email" : email, "password": password, "isAdmin": false]
        return request(api: APIConstants.signIn.rawValue, method: .post, params: params)
    }
    
    func sendOTP(email: String) -> Observable<User> {
        let param = ["email" : email]
        return authRequest(api: APIConstants.sendOTP, method: .post, parameters: param)
    }
    
    func confirmOTP(email: String, otp: String) -> Observable<User> {
        let params = ["email" : email, "otp" : otp]
        return authRequest(api: APIConstants.confirmOTP, method: .post, parameters: params)
    }
    
    func register(email: String, otp: String, password: String) -> Observable<User> {
        let params = ["email" : email, "otp" : otp, "password": password]
        return authRequest(api: APIConstants.register, method: .post, parameters: params)
    }
    
    func updateInfo(user: User) -> Observable<User> {
        return authRequest(api: APIConstants.updateInfo, method: .put, parameters: user)
    }
    
    func sendOTPResetPassword(email: String) -> Observable<User> {
        let param = ["email" : email]
        return authRequest(api: APIConstants.sendOTPResetPassword, method: .post, parameters: param)
    }
    
    func resetPassword(email: String, otp: String, password: String) -> Observable<User> {
        let params = ["email" : email, "otp" : otp, "password": password]
        return authRequest(api: APIConstants.resetPassword, method: .put, parameters: params)
    }
    
    func changePassword(oldPassword: String, newPassword: String) -> Observable<User> {
        let params = ["oldPassword": oldPassword, "newPassword": newPassword]
        return authRequest(api: APIConstants.changePassword, method: .put, parameters: params)
    }
    
    func likePost(postId: String) -> Observable<String> {
        return request(api: APIConstants.likePost.rawValue + postId, method: .put)
    }
    
    func dislikePost(postId: String) -> Observable<String> {
        return request(api: APIConstants.dislikePost.rawValue + postId, method: .put)
    }

    func getUserById(userId: String) -> Observable<User> {
        return request(api: APIConstants.getUserById.rawValue + userId, method: .get)
    }
}
