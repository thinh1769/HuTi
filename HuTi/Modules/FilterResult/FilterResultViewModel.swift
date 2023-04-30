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
    var postList = [Post]()
    let project = BehaviorRelay<[Project]>(value: [])
    var projectList = [Project]()
    let options = BehaviorRelay<[String]>(value: [])
    var tabBarItemTitle = TabBarItemTitle.sell
    var mainTabBarItemTitle = MainTitle.sell
    var tuppleOptionsList = [(key: Int, value: String)]()
    var findPostParams = [String: Any]()
    let getApprovedPostParam = ["browseStatus": 1]
    var searchProjectParams = [String: Any]()
    var selectedProvince = (index: -1, id: "")
    var selectedDistrict = (index: -1, id: "")
    var page = 1
    
    func getListPosts(isSell: Bool) -> Observable<[Post]> {
        return postService.getListPosts(isSell: isSell, page: page)
    }
    
    func getListProjects() -> Observable<[Project]> {
        return projectService.getListProjects(page: page)
    }
    
    func appendProjectToArray(projects: [Project]) {
        for project in projects {
            projectList.append(project)
        }
    }
    
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
    
    func findProject() -> Observable<[Project]> {
        return projectService.findProject(params: searchProjectParams, page: page)
    }
}
