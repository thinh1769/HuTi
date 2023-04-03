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
    let awsService = AWSService()
    let province = BehaviorRelay<[(id: String, name: String)]>(value: [])
    let district = BehaviorRelay<[(id: String, name: String)]>(value: [])
    let ward = BehaviorRelay<[(id: String, name: String)]>(value: [])
    var selectedProvince = 0
    var selectedDistrict = 0
    var selectedWard = 0
    
    func parseProvincesArray(provinces: [Province]) -> [(id: String, name: String)] {
        var provinceArray = [(id: String, name: String)]()
        for (_, element) in provinces.enumerated() {
            provinceArray.append((id: element.code, name: element.name))
        }
        return provinceArray
    }
    
    func parseDistrictsArray(districts: [District]) -> [(id: String, name: String)] {
        var districtArray = [(id: String, name: String)]()
        for (_, element) in districts.enumerated() {
            districtArray.append((id: element.code, name: element.name))
        }
        return districtArray
    }
    
    func parseWardsArray(wards: [Ward]) -> [(id: String, name: String)] {
        var wardArray = [(id: String, name: String)]()
        for (_, element) in wards.enumerated() {
            wardArray.append((id: element.code, name: element.name))
        }
        return wardArray
    }
    
    func getAllProvinces() -> Observable<[Province]> {
        return addressService.getAllProvinces()
    }
    
    func getDistrictsByProvinceId() -> Observable<[District]> {
        return addressService.getDistrictsByProvinceId(provinceId: province.value[selectedProvince].id)
    }
    
    func getWardsByDistrictId() -> Observable<[Ward]> {
        return addressService.getWardsByDistrictId(districtId: district.value[selectedDistrict].id)
    }
}
