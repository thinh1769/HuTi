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
                    acreageRange: getAcreageRange(acreage: acreage),
                    price: price,
                    priceRange: getPriceRange(price: price),
                    legal: legal.value[selectedLegal],
                    funiture: funiture.value[selectedFuniture],
                    bedroom: bedroom,
                    bedroomRange: getBedroomRange(bedroom: bedroom),
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
    
    private func getPriceRange(price: Double) -> String {
        if price < 500000000 {
            return PickerData.price[1]
        } else if price < 800000000 {
            return PickerData.price[2]
        } else if price < 1000000000 {
            return PickerData.price[3]
        } else if price < 2000000000 {
            return PickerData.price[4]
        } else if price < 3000000000 {
            return PickerData.price[5]
        } else if price < 5000000000 {
            return PickerData.price[6]
        } else if price < 7000000000 {
            return PickerData.price[7]
        } else if price < 10000000000 {
            return PickerData.price[8]
        } else if price < 20000000000 {
            return PickerData.price[9]
        } else if price < 30000000000 {
            return PickerData.price[10]
        } else if price < 40000000000 {
            return PickerData.price[11]
        } else if price < 60000000000 {
            return PickerData.price[12]
        } else {
            return PickerData.price[13]
        }
    }
    
    private func getAcreageRange(acreage: Double) -> String {
        if acreage < 30 {
            return PickerData.acreage[1]
        } else if acreage < 50 {
            return PickerData.acreage[2]
        } else if acreage < 80 {
            return PickerData.acreage[3]
        } else if acreage < 100 {
            return PickerData.acreage[4]
        } else if acreage < 150 {
            return PickerData.acreage[5]
        } else if acreage < 200 {
            return PickerData.acreage[6]
        } else if acreage < 250 {
            return PickerData.acreage[7]
        } else if acreage < 300 {
            return PickerData.acreage[8]
        } else if acreage < 500 {
            return PickerData.acreage[9]
        } else {
            return PickerData.acreage[10]
        }
    }
    
    private func getBedroomRange(bedroom: Int) -> String {
        if bedroom == 1 {
            return PickerData.bedroom[0]
        } else if bedroom == 2{
            return PickerData.bedroom[1]
        } else if bedroom == 3 {
            return PickerData.bedroom[2]
        } else if bedroom == 4 {
            return PickerData.bedroom[3]
        } else {
            return PickerData.bedroom[4]
        }
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
}


