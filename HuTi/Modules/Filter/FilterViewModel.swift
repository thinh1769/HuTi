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
    var selectedFilterType = -1
    var selectedPrice = -1
    var selectedAcreage = -1
    var selectedBedroom = -1
    var selectedFilterHouseDirection = -1
    var selectedStatus = -1
    var optionsList = [(key: Int, value: String)]()
    var searchPostParams = [String: Any]()
    var searchProjectParams = [String: Any]()
    
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
            if province.value.count > 0 && selectedProvince >= 0 {
                return province.value[selectedProvince].name
            } else if selectedProvince == -1 {
                selectedProvince = 0
                return province.value[0].name
            } else {
                return ""
            }
        case PickerTag.district:
            if district.value.count > 0 && selectedDistrict >= 0 {
                return district.value[selectedDistrict].name
            } else if selectedDistrict == -1 {
                selectedDistrict = 0
                return district.value[0].name
            } else {
                return ""
            }
        case PickerTag.ward:
            if ward.value.count > 0 && selectedWard >= 0 {
                return ward.value[selectedWard].name
            } else if selectedWard == -1 {
                selectedWard = 0
                return ward.value[0].name
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
        return postService.findPost(param: searchPostParams)
    }
    
    func findProject() -> Observable<[Project]> {
        return projectService.findProject(params: searchProjectParams)
    }
}
