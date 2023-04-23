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
    var searchPostParams = [String: Any]()
    var searchProjectParams = [String: Any]()
    var page = 1
    
    func getListPosts(isSell: Bool) -> Observable<[Post]> {
        return postService.getListPosts(isSell: isSell, page: page)
    }
    
//    func searchProject() {
//        prepareProjectParam()
//        viewModel.findProject().subscribe { [weak self] projects in
//            guard let self = self else { return }
//            self.delegate?.didTapApplyButton(listOptions: self.getApplyOptions(), selectedProvince: self.viewModel.selectedProvince, selectedDistrict: self.viewModel.selectedDistrict)
//            self.isHiddenMainTabBar = false
//            self.backToPreviousView()
//        }.disposed(by: viewModel.bag)
//    }
    
    func appendPostToArray(posts: [Post]) {
        for post in posts {
            postList.append(post)
        }
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
    
    func findPost() -> Observable<[Post]> {
        return postService.findPost(param: searchPostParams, page: page)
    }
    
    func findProject() -> Observable<[Project]> {
        return projectService.findProject(params: searchProjectParams, page: page)
    }
}
