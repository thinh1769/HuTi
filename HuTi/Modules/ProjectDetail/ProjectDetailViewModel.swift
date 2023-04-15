//
//  ProjectDetailViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 01/04/2023.
//

import Foundation
import RxSwift
import RxRelay

class ProjectDetailViewModel: BaseViewModel {
    var project : Project?
    let images = BehaviorRelay<[String]>(value: [])
    let relatedPost = BehaviorRelay<[Post]>(value: [])
    var projectId = ""
    
    func getRelatedPost() -> Observable<[Post]> {
        let param = ["project": project?.id ?? ""]
        return postService.findPost(param: param)
    }
    
    func getProjectById() -> Observable<Project> {
        return projectService.getProjectById(projectId: projectId)
    }
}
