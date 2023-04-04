//
//  PostDetailViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 01/04/2023.
//

import Foundation
import RxSwift
import RxRelay

class PostDetailViewModel: BaseViewModel {
    var postId = ""
    let images = BehaviorRelay<[String]>(value: [])
    var postDetail: PostDetail?
    
    func getPostDetail(postId: String) -> Observable<PostDetail> {
        return postService.getPostById(postId: postId)
    }
}
