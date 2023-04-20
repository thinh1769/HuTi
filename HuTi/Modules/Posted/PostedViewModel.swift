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
    var page = 1
    var postList = [Post]()
    
    func getPostedPost() -> Observable<[Post]> {
        return postService.getPostByUserId(page: page)
    }
    
    func appendPostToArray(posts: [Post]) {
        for post in posts {
            postList.append(post)
        }
    }
    
    func getFavoritePost() -> Observable<[Post]> {
        return postService.getFavoritePost(page: page)
    }
}
