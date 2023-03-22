//
//  BaseService.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 21/03/2023.
//

import Foundation
import Alamofire
import RxSwift

class AdministrativeService {
    func request<Response: Codable>(administrativeURL: String, id: String? = nil, method: HTTPMethod = .get) -> Observable<Response> {
        var url = administrativeURL
        if let id = id {
            url += id + AdministrativeURL.urlTail
        }

        return performRequest(request: AF.request(url, method: method, encoding: JSONEncoding.default))
    }

    private func performRequest<Response: Codable>(request: DataRequest) -> Observable<Response> {
        AF.sessionConfiguration.timeoutIntervalForRequest = 30
        AF.sessionConfiguration.timeoutIntervalForResource = 60
        return Observable.create { observer in
            request.responseDecodable(of: ResponseMain<Response>.self) { response in
                if response.error != nil {
                    print("Gọi api hành chính thất bại")
                } else if let data = response.value {
                    print("data hành chính gọi được = \(data)")
                } else {
                    print("Gọi api hành chính thất bại")
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}


