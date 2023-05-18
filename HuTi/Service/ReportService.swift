//
//  ReportService.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 18/05/2023.
//

import Foundation
import RxSwift
import RxRelay

class ReportService: BaseService {
    func addReport(params: [String: Any]) -> Observable<String> {
        return request(api: APIConstants.addReport.rawValue, method: .post, params: params)
    }
}
