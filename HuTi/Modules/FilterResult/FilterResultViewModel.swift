//
//  FilterResultViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import Foundation
import RxCocoa
import RxSwift

class FilterResultViewModel: BaseViewModel {
    var optionsList = [String]()
    let post = BehaviorRelay<[Post]>(value: [])
    let project = BehaviorRelay<[Project]>(value: [])
    let options = BehaviorRelay<[String]>(value: [])
    var tabBarItemTitle = TabBarItemTitle.sell
    var mainTabBarItemTitle = MainTitle.sell
    var tuppleOptionsList = [(key: Int, value: String)]()
    var findPostParams = [String: Any]()
    var getApprovedPostParam: [String: Any] = ["browseStatus": 1, "status": 0]
    var findProjectParams = [String: Any]()
    var selectedProvince = (index: -1, id: "")
    var selectedDistrict = (index: -1, id: "")
    var page = 1
    
    //    func getListPosts(isSell: Bool) -> Observable<[Post]> {
    //        return postService.getListPosts(isSell: isSell, page: page)
    //    }
    //
    //    func getListProjects() -> Observable<[Project]> {
    //        return projectService.getListProjects(page: page)
    //    }
    
    func parseOptionTuppleToArray() {
        optionsList = []
        for (_, element) in tuppleOptionsList.enumerated() {
            optionsList.append(element.value)
        }
        options.accept(optionsList)
    }
    
    func getIndexOfSelectedPost(postId: String) -> Int {
        let posts = post.value
        for (index, element) in posts.enumerated() {
            if element.id == postId {
                return index
            }
        }
        return -1
    }
    
    func findPost(param: [String: Any]) -> Observable<[Post]> {
        return postService.findPost(param: param, page: page)
    }
    
    func findProject(param: [String: Any]) -> Observable<[Project]> {
        return projectService.findProject(params: param, page: page)
    }
    
    func searchPostByKeyword(keyword: String) -> Observable<[Post]> {
        return postService.searchKeyword(keyword: keyword, page: page)
    }
    
    func searchProjectByKeyword(keyword: String) -> Observable<[Project]> {
        return projectService.searchByKeyword(keyword: keyword, page: page)
    }
    
    func filterPostAfterSearchByKeyword(posts: [Post]) -> [Post] {
        if posts.count > 0 {
            var result = [Post]()
            for post in posts {
                if let isSell = post.isSell {
                    if isSell && tabBarItemTitle == TabBarItemTitle.sell ||
                        !isSell && tabBarItemTitle == TabBarItemTitle.forRent {
                        result.append(post)
                    }
                }
            }
            return result
        } else {
            return [Post]()
        }
    }
}
