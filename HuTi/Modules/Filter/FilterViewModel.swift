//
//  FilterViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 23/03/2023.
//

import Foundation
import RxSwift
import RxRelay

class FilterViewModel {
    let bag = DisposeBag()
    var tabBarItemTitle = TabBarItemTitle.sell
    let type = BehaviorRelay<[String]>(value: [])
    let city = BehaviorRelay<[String]>(value: [])
    let district = BehaviorRelay<[String]>(value: [])
    let ward = BehaviorRelay<[String]>(value: [])
    let price = BehaviorRelay<[String]>(value: [])
    let acreage = BehaviorRelay<[String]>(value: [])
    let bedroom = BehaviorRelay<[String]>(value: [])
    let houseDirection = BehaviorRelay<[String]>(value: [])
    let status = BehaviorRelay<[String]>(value: [])
    var selectedType = 0
    var selectedCity = 0
    var selectedDistrict = 0
    var selectedWard = 0
    var selectedPrice = 0
    var selectedAcreage = 0
    var selectedBedroom = 0
    var selectedHouseDirection = 0
    var selectedStatus = 0
    var optionsList = [(key: Int, value: String)]()
    
    func pickItem(pickerTag: Int) -> String? {
        switch pickerTag{
        case PickerTag.type:
            if type.value.count > 0 {
                return type.value[selectedType]
            } else {
                return ""
            }
        case PickerTag.city:
            if city.value.count > 0 {
                return city.value[selectedCity]
            } else {
                return ""
            }
        case PickerTag.district:
            if district.value.count > 0 {
                return district.value[selectedDistrict]
            } else {
                return ""
            }
        case PickerTag.ward:
            if ward.value.count > 0 {
                return ward.value[selectedWard]
            } else {
                return ""
            }
        case PickerTag.price:
            if price.value.count > 0 {
                return price.value[selectedPrice]
            } else {
                return ""
            }
        case PickerTag.acreage:
            if acreage.value.count > 0 {
                return acreage.value[selectedAcreage]
            } else {
                return ""
            }
        case PickerTag.bedroom:
            if bedroom.value.count > 0 {
                return bedroom.value[selectedBedroom]
            } else {
                return ""
            }
        case PickerTag.houseDirection:
            if houseDirection.value.count > 0 {
                return houseDirection.value[selectedHouseDirection]
            } else {
                return ""
            }
        case PickerTag.status:
            if status.value.count > 0 {
                return status.value[selectedStatus]
            } else {
                return ""
            }
        default:
            return ""
        }
    }
}
