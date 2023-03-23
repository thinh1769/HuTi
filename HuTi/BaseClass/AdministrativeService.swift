//
//  AdministrativeService.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 22/03/2023.
//

import Foundation
import AFNetworking
import RxCocoa
import RxSwift

class AdministrativeService {
    let manager = AFHTTPRequestOperationManager()
    
    func getAllCities(completion: @escaping([City]) -> Void) {
        var listData = [NSDictionary]()
        var result = [City]()
        
        manager.get(AdministrativeURL.getAllProvinces, parameters: nil) { operation, responseObject in
            DispatchQueue.main.async {
                let data = responseObject as! NSDictionary
                let data1 = data["data"] as! NSDictionary
                listData = data1["data"] as! [NSDictionary]
                for index in listData {
                    let administrativeIndex = index
                    let name = (administrativeIndex["name"]) as! String
                    let id = (administrativeIndex["code"]) as! String
                    result.append(City(id: id, name: name))
                }
                completion(result)
            }
        } failure: { _, _ in
            }
    }
    
    func getDistrictsByCityId(completion: @escaping([City]) -> Void) {
        var listData = [NSDictionary]()
        var result = [City]()
        
        manager.get(AdministrativeURL.getAllProvinces, parameters: nil) { operation, responseObject in
            DispatchQueue.main.async {
                let data = responseObject as! NSDictionary
                let data1 = data["data"] as! NSDictionary
                listData = data1["data"] as! [NSDictionary]
                for index in listData {
                    let administrativeIndex = index
                    let name = (administrativeIndex["name"]) as! String
                    let id = (administrativeIndex["code"]) as! String
                    result.append(City(id: id, name: name))
                }
                completion(result)
            }
        } failure: { _, _ in
            }
    }
}
