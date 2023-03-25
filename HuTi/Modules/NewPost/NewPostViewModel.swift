//
//  NewPostViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 19/03/2023.
//

import Foundation
import RxSwift
import RxRelay

class NewPostViewModel {
    let bag = DisposeBag()
    let typeRealEstate = BehaviorRelay<[String]>(value: [])
    let city = BehaviorRelay<[String]>(value: [])
    let district = BehaviorRelay<[String]>(value: [])
    let ward = BehaviorRelay<[String]>(value: [])
    let project = BehaviorRelay<[String]>(value: [])
    let legal = BehaviorRelay<[String]>(value: [])
    let funiture = BehaviorRelay<[String]>(value: [])
    let houseDirection = BehaviorRelay<[String]>(value: [])
    let balconyDirection = BehaviorRelay<[String]>(value: [])
    var selectedType = 0
    var selectedCity = 0
    var selectedDistrict = 0
    var selectedWard = 0
    var selectedProject = 0
    var selectedLegal = 0
    var selectedFuniture = 0
    var selectedHouseDirection = 0
    var selectedBalconyDirection = 0
    var isSelectedSell = true
    var isEditBtnClicked = false
    
    func pickItem(pickerTag: Int) -> String? {
        switch pickerTag{
        case PickerTag.type:
            if typeRealEstate.value.count > 0 {
                return typeRealEstate.value[selectedType]
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
        case PickerTag.project:
            if project.value.count > 0 {
                return project.value[selectedProject]
            } else {
                return ""
            }
        case PickerTag.legal:
            if legal.value.count > 0 {
                return legal.value[selectedLegal]
            } else {
                return ""
            }
        case PickerTag.funiture:
            if funiture.value.count > 0 {
                return funiture.value[selectedFuniture]
            } else {
                return ""
            }
        case PickerTag.houseDirection:
            if houseDirection.value.count > 0 {
                return houseDirection.value[selectedHouseDirection]
            } else {
                return ""
            }
        case PickerTag.balconyDirection:
            if balconyDirection.value.count > 0 {
                return balconyDirection.value[selectedBalconyDirection]
            } else {
                return ""
            }
        default:
            return ""
        }
    }
}


