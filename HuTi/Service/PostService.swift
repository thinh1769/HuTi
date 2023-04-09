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
    
    func getListPosts(isSell: Bool) -> Observable<[Post]> {
        let param = ["isSell": isSell]
        return request(api: APIConstants.getPosts.rawValue, method: .post, params: param)
    }
    
    func getPostById(postId: String) -> Observable<PostDetail> {
        return request(api: APIConstants.getPostById.rawValue + postId, method: .get)
    }
    
    func getPostByUserId() -> Observable<[Post]> {
        return request(api: .getPostByUserId)
    }
    
    func findPost(param: [String: Any]) -> Observable<[Post]> {
        return request(api: APIConstants.findPost.rawValue, method: .post, params: param)
    }
}
