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
    
    func getListPosts(isSell: Bool, page: Int) -> Observable<[Post]> {
        let param = ["isSell": isSell]
        return request(api: "\(APIConstants.getPosts.rawValue)?page=\(page)" , method: .post, params: param)
    }
    
    func getPostById(postId: String) -> Observable<PostDetail> {
        return request(api: APIConstants.getPostById.rawValue + postId, method: .get)
    }
    
    func getPostByUserId(page: Int) -> Observable<[Post]> {
        return request(api: "\(APIConstants.getPostByUserId.rawValue)?page=\(page)", method: .get)
    }
    
    func getFavoritePost(page: Int) -> Observable<[Post]> {
        return request(api: "\(APIConstants.getFavoritePost.rawValue)?page=\(page)", method: .get)
    }
    
    func findPost(param: [String: Any], page: Int) -> Observable<[Post]> {
        return request(api: "\(APIConstants.findPost.rawValue)?page=\(page)", method: .post, params: param)
    }
}
