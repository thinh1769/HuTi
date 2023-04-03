//
//  PostService.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 01/04/2023.
//

import Foundation
import RxSwift
import RxRelay

class PostService: BaseService {
    func addPost(post: PostDetail) -> Observable<PostDetail> {
        return request(api: APIConstants.addNewPost.rawValue, method: .post, params: post)
    }
    
    func getPosts(isSell: Bool) -> Observable<[Post]> {
        let param = ["isSell": isSell]
        return request(api: APIConstants.getPosts.rawValue, method: .post, params: param)
    }
}
