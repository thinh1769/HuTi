//
//  FilterViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 23/03/2023.
//

import Foundation
import RxSwift
import RxRelay

class FilterViewModel: BaseViewModel {
    var tabBarItemTitle = TabBarItemTitle.sell
    let type = BehaviorRelay<[String]>(value: [])
    let price = BehaviorRelay<[String]>(value: [])
    let acreage = BehaviorRelay<[String]>(value: [])
    let bedroom = BehaviorRelay<[String]>(value: [])
    let houseDirection = BehaviorRelay<[String]>(value: [])
    let status = BehaviorRelay<[String]>(value: [])
    var selectedProvince = (index: -1, id: "")
    var selectedDistrict = (index: -1, id: "")
    var selectedWard = -1
    var selectedFilterType = -1
    var selectedPrice = -1
    var selectedAcreage = -1
    var selectedBedroom = -1
    var selectedFilterHouseDirection = -1
    var selectedStatus = -1
    var optionsList = [(key: Int, value: String)]()
    var searchPostParams = [String: Any]()
    var searchProjectParams = [String: Any]()
    var page = 1
    
    func getAllProvinces() -> Observable<[Province]> {
        return addressService.getAllProvinces()
    }
    
    func getDistrictsByProvinceId() -> Observable<[District]> {
        return addressService.getDistrictsByProvinceId(provinceId: selectedProvince.id)
    }
    
    func getWardsByDistrictId() -> Observable<[Ward]> {
        return addressService.getWardsByDistrictId(districtId: selectedDistrict.id)
    }
    
    func pickItem(pickerTag: Int) -> String? {
        switch pickerTag{
        case PickerTag.type:
            if type.value.count > 0 && selectedFilterType >= 0 {
                return type.value[selectedFilterType]
            } else if selectedFilterType == -1 {
                selectedFilterType = 0
                return type.value[0]
            } else {
                return ""
            }
        case PickerTag.province:
            if province.value.count > 0 && selectedProvince.index >= 0 {
                selectedProvince.id = province.value[selectedProvince.index].id
                return province.value[selectedProvince.index].name
            } else if selectedProvince.index == -1 {
                selectedProvince.index = 0
                selectedProvince.id = province.value[0].id
                return province.value[0].name
            } else {
                return ""
            }
        case PickerTag.district:
            if district.value.count > 0 && selectedDistrict.index >= 0 {
                selectedDistrict.id = district.value[selectedDistrict.index].id
                return district.value[selectedDistrict.index].name
            } else {
                return ""
            }
        case PickerTag.ward:
            if ward.value.count > 0 && selectedWard >= 0 {
                return ward.value[selectedWard].name
            } else {
                return ""
            }
        case PickerTag.price:
            if price.value.count > 0 && selectedPrice >= 0 {
                return price.value[selectedPrice]
            } else if selectedPrice == -1 {
                selectedPrice = 0
                return price.value[0]
            } else {
                return ""
            }
        case PickerTag.acreage:
            if acreage.value.count > 0 && selectedAcreage >= 0 {
                return acreage.value[selectedAcreage]
            } else if selectedAcreage == -1 {
                selectedAcreage = 0
                return acreage.value[0]
            } else {
                return ""
            }
        case PickerTag.bedroom:
            if bedroom.value.count > 0 && selectedBedroom >= 0 {
                return bedroom.value[selectedBedroom]
            } else if selectedBedroom == -1 {
                selectedBedroom = 0
                return bedroom.value[0]
            } else {
                return ""
            }
        case PickerTag.houseDirection:
            if houseDirection.value.count > 0 && selectedFilterHouseDirection >= 0 {
                return houseDirection.value[selectedFilterHouseDirection]
            } else if selectedFilterHouseDirection == -1 {
                selectedFilterHouseDirection = 0
                return houseDirection.value[0]
            } else {
                return ""
            }
        case PickerTag.status:
            if status.value.count > 0 && selectedStatus >= 0 {
                return status.value[selectedStatus]
            } else if selectedStatus == -1 {
                selectedStatus = 0
                return status.value[0]
            } else {
                return ""
            }
        default:
            return ""
        }
    }
    
    func findPost() -> Observable<[Post]> {
        return postService.findPost(param: searchPostParams, page: page)
    }
    
    func findProject() -> Observable<[Project]> {
        return projectService.findProject(params: searchProjectParams, page: page)
    }
}
