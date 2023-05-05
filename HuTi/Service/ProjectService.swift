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
    func getListProjects(page: Int) -> Observable<[Project]> {
        return request(api: "\(APIConstants.getProject.rawValue)?page=\(page)", method: .get)
    }
    
    func getProjectById(projectId: String) -> Observable<Project> {
        return request(api: APIConstants.getProjectById.rawValue + projectId, method: .get)
    }
    
    func findProject(params: [String: Any], page: Int?) -> Observable<[Project]> {
        if let page = page {
            return request(api: "\(APIConstants.findProject.rawValue)?page=\(page)", method: .post, params: params)
        } else {
            return request(api: APIConstants.findProject.rawValue, method: .post, params: params)
        }
    }
    
    func searchByKeyword(keyword: String, page: Int) -> Observable<[Project]> {
        let param: [String: Any] = ["keyword": keyword]
        return request(api: "\(APIConstants.searchProjectByKeyword.rawValue)?page=\(page)", method: .post, params: param)
    }
}
