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
    
    func getListPosts(isSell: Bool) -> Observable<[Post]> {
        return postService.getListPosts(isSell: isSell)
    }
    
    func getListProjects() -> Observable<[Project]> {
        return projectService.getListProjects()
    }
    
    func parseOptionTuppleToArray() {
        optionsList = []
        for (_, element) in tuppleOptionsList.enumerated() {
            optionsList.append(element.value)
        }
        options.accept(optionsList)
    }
}
