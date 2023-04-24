//
//  BaseViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 01/04/2023.
//

import Foundation
import RxSwift
import RxRelay

class BaseViewModel {
    let bag = DisposeBag()
    let authService = AuthService()
    let addressService = AddressService()
    let postService = PostService()
    let projectService = ProjectService()
    let awsService = AWSService()
    let province = BehaviorRelay<[(id: String, name: String)]>(value: [])
    let district = BehaviorRelay<[(id: String, name: String)]>(value: [])
    let ward = BehaviorRelay<[(id: String, name: String)]>(value: [])
    
    func parseProvincesArray(provinces: [Province]) -> [(id: String, name: String)] {
        var provinceArray = [(id: String, name: String)]()
        for (_, element) in provinces.enumerated() {
            provinceArray.append((id: element.code, name: element.name))
        }
        let sortedProvince = provinceArray.sorted { $0.name < $1.name }
        return sortedProvince
    }
    
    func parseDistrictsArray(districts: [District]) -> [(id: String, name: String)] {
        var districtArray = [(id: String, name: String)]()
        for (_, element) in districts.enumerated() {
            districtArray.append((id: element.code, name: element.name))
        }
        let sortedDistrict = districtArray.sorted { $0.name < $1.name }
        return sortedDistrict
    }
    
    func parseWardsArray(wards: [Ward]) -> [(id: String, name: String)] {
        var wardArray = [(id: String, name: String)]()
        for (_, element) in wards.enumerated() {
            wardArray.append((id: element.code, name: element.name))
        }
        let sortedWard = wardArray.sorted { $0.name < $1.name }
        return sortedWard
    }
}
