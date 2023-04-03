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
    let selectedImage = BehaviorRelay<[UIImage]>(value: [])
    var selectedType = 0
    var selectedProject = 0
    var selectedLegal = 0
    var selectedFuniture = 0
    var selectedHouseDirection = 0
    var selectedBalconyDirection = 0
    var isSelectedSell = true
    var isEditBtnClicked = false
    var imageSelected = UIImage()
    var images = [UIImage]()
    var imagesName = [String]()
    
    func setupDataImageCollectionView() {
        selectedImage.accept(images)
    }
    
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
    
    func addNewPost(address: String, long: Double, lat: Double, title: String, description: String, acreage: Double, price: Double, bedroom: Int, bathroom: Int, floor: Int, wayIn: Double, facade: Double, contactName: String, contactPhoneNumber: String) -> Observable<PostDetail> {
        return postService.addPost(post: PostDetail(
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
                    images: imagesName,
                    contactName: contactName,
                    contactPhoneNumber: contactPhoneNumber))
    }
    
    func uploadImage(completion: @escaping() -> Void) {
        guard let data = imageSelected.pngData() else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = CommonConstants.dateFormatAWSS3
        
        let assetDataModel = AssetDataModel(data: data, pathFile: "", thumbnail: imageSelected)
        assetDataModel.compressed = true
        assetDataModel.compressData()
        assetDataModel.remoteName = "\(UserDefaults.userInfo?.id ?? "")_" + formatter.string(from: Date())
        imagesName.append(assetDataModel.remoteName)
        
        awsService.uploadImage(data: assetDataModel, completionHandler:  { [weak self] _, error in
            guard self != nil else { return }
            if error != nil {
                print("---------------- Lỗi upload lên AWS S3 : \(String(describing: error))")
            }
            completion()
        })
    }
    
    func getImage(remoteName: String, completion: @escaping(UIImage) -> Void) {
        awsService.getImage(remoteName: remoteName) { data in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            print("download image successfully")
            completion(image)
        }
    }
}


