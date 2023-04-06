//
//  ProjectService.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 06/04/2023.
//

import Foundation
import RxSwift
import RxRelay

class ProjectService: BaseService {
    func getListProjects() -> Observable<[Project]> {
        return request(api: APIConstants.getProject.rawValue, method: .get)
    }
    
    func getProjectById(projectId: String) -> Observable<Project> {
        return request(api: APIConstants.getProjectById.rawValue + projectId, method: .get)
    }
    
    func findProject(params: [String: Any]) -> Observable<[Project]> {
        return request(api: APIConstants.findProject.rawValue, method: .post, params: params)
    }
    
}
