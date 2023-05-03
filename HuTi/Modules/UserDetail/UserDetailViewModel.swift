//
//  UserDetailViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 03/05/2023.
//

import Foundation
import RxSwift
import RxRelay

class UserDetailViewModel: BaseViewModel {
    let post = BehaviorRelay<[Post]>(value: [])
    var userId = ""
    var user: User?
    var page = 1
    
    func getPostByUser() -> Observable<[Post]> {
        return postService.getPostByUserId(page: page, userId: userId)
    }
    
    func getUserById() -> Observable<User> {
        return authService.getUserById(userId: userId)
    }
}
