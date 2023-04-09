//
//  PostedViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 13/03/2023.
//

import Foundation
import RxSwift
import RxCocoa

class PostedViewModel: BaseViewModel {
    var title = MainTitle.postedPosts
    let post = BehaviorRelay<[Post]>(value: [])
    
    func getPostedPost() -> Observable<[Post]> {
        return postService.getPostByUserId()
    }
}
