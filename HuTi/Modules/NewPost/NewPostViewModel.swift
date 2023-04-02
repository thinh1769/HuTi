//
//  NewPostViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 19/03/2023.
//

import Foundation
import RxSwift
import RxRelay

class NewPostViewModel: BaseViewModel {
    let realEstateType = BehaviorRelay<[String]>(value: [])
    let project = BehaviorRelay<[String]>(value: [])
    let legal = BehaviorRelay<[String]>(value: [])
    let funiture = BehaviorRelay<[String]>(value: [])
    let houseDirection = BehaviorRelay<[String]>(value: [])
    let balconyDirection = BehaviorRelay<[String]>(value: [])
    var selectedType = 0
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
            if realEstateType.value.count > 0 {
                return realEstateType.value[selectedType]
            } else {
                return ""
            }
        case PickerTag.province:
            if province.value.count > 0 {
                return province.value[selectedProvince].name
            } else {
                return ""
            }
        case PickerTag.district:
            if district.value.count > 0 {
                return district.value[selectedDistrict].name
            } else {
                return ""
            }
        case PickerTag.ward:
            if ward.value.count > 0 {
                return ward.value[selectedWard].name
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
    
    func addNewPost(address: String, long: Double, lat: Double, title: String, description: String, acreage: Double, price: Double, bedroom: Int, bathroom: Int, floor: Int, wayIn: Double, facade: Double, contactName: String, contactPhoneNumber: String) -> Observable<Post> {
        return postService.addPost(post: Post(userId: UserDefaults.userInfo?.id ?? "",
                    isSell: isSelectedSell,
                    realEstateType: realEstateType.value[selectedType],
                    provinceCode: province.value[selectedProvince].id,
                    districtCode: district.value[selectedDistrict].id,
                    wardCode: ward.value[selectedWard].id,
                    provinceName: province.value[selectedProvince].name,
                    districtName: district.value[selectedDistrict].name,
                    wardName: ward.value[selectedWard].name,
                    address: address,
                    lat: lat,
                    long: long,
                    title: title,
                    description: description,
                    acreage: acreage,
                    acreageRange: "50 - 70 m2",
                    price: price,
                    priceRange: "5 - 6 tỷ",
                    legal: legal.value[selectedLegal],
                    funiture: funiture.value[selectedFuniture],
                    bedroom: bedroom,
                    bathroom: bathroom,
                    floor: floor,
                    houseDirection: houseDirection.value[selectedHouseDirection],
                    balconyDirection: balconyDirection.value[selectedBalconyDirection],
                    wayIn: wayIn,
                    facade: facade,
                    images: ["hinh1", "hinh2"],
                    contactName: contactName,
                    contactPhoneNumber: contactPhoneNumber))
    }
}


