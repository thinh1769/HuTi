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
    let project = BehaviorRelay<[(id: String, name: String)]>(value: [])
    let legal = BehaviorRelay<[String]>(value: [])
    let funiture = BehaviorRelay<[String]>(value: [])
    let houseDirection = BehaviorRelay<[String]>(value: [])
    let balconyDirection = BehaviorRelay<[String]>(value: [])
    let selectedImage = BehaviorRelay<[UIImage]>(value: [])
    let imagesName = BehaviorRelay<[String]>(value: [])
    var selectedProvince = -1
    var selectedDistrict = -1
    var selectedWard = -1
    var selectedType = -1
    var selectedProject = -1
    var selectedLegal = -1
    var selectedFuniture = -1
    var selectedHouseDirection = -1
    var selectedBalconyDirection = -1
    var isSelectedSell = true
    var isEditBtnClicked = false
    var imageSelected = UIImage()
    var imagesList = [UIImage]()
    var imagesNameList = [String]()
    var searchProjectParams = [String: Any]()
    var isEdit = false
    var post: PostDetail?
    var projectDetail: Project?
    var updatePostParams = [String: Any]()
    var newPostParams = [String: Any]()
    
    func setupDataImageCollectionView() {
        selectedImage.accept(imagesList)
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
    
    func pickItem(pickerTag: Int) -> String? {
        switch pickerTag{
        case PickerTag.type:
            if realEstateType.value.count > 0 && selectedType >= 0 {
                return realEstateType.value[selectedType]
            } else if selectedType == -1 {
                selectedType = 0
                return realEstateType.value[0]
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
            } else if selectedDistrict == -1 && district.value.count > 0 {
                selectedDistrict = 0
                return district.value[0].name
            } else {
                return ""
            }
        case PickerTag.ward:
            if ward.value.count > 0 && selectedWard >= 0 {
                return ward.value[selectedWard].name
            } else if selectedWard == -1 && ward.value.count > 0 {
                selectedWard = 0
                return ward.value[0].name
            } else {
                return ""
            }
        case PickerTag.project:
            if project.value.count > 0 && selectedProject >= 0 {
                return project.value[selectedProject].name
            } else if selectedProject == -1 {
                selectedProject = 0
                return project.value[0].name
            } else {
                return ""
            }
        case PickerTag.legal:
            if legal.value.count > 0 && selectedLegal >= 0 {
                return legal.value[selectedLegal]
            } else if selectedLegal == -1 {
                selectedLegal = 0
                return legal.value[0]
            } else {
                return ""
            }
        case PickerTag.funiture:
            if funiture.value.count > 0 && selectedFuniture >= 0 {
                return funiture.value[selectedFuniture]
            } else if selectedFuniture == -1 {
                selectedFuniture = 0
                return funiture.value[0]
            } else {
                return ""
            }
        case PickerTag.houseDirection:
            if houseDirection.value.count > 0 && selectedHouseDirection >= 0 {
                return houseDirection.value[selectedHouseDirection]
            } else if selectedHouseDirection == -1 {
                selectedHouseDirection = 0
                return houseDirection.value[0]
            } else {
                return ""
            }
        case PickerTag.balconyDirection:
            if balconyDirection.value.count > 0 && selectedBalconyDirection >= 0 {
                return balconyDirection.value[selectedBalconyDirection]
            } else if selectedBalconyDirection == -1 {
                selectedBalconyDirection = 0
                return balconyDirection.value[0]
            } else {
                return ""
            }
        default:
            return ""
        }
    }
    
    func addNewPost(address: String, long: Double, lat: Double, title: String, description: String, acreage: Double, price: Int, bedroom: Int, bathroom: Int, floor: Int, wayIn: Double, facade: Double, contactName: String, contactPhoneNumber: String) -> Observable<PostDetail> {
        
        /// Required Field
        newPostParams.updateValue(isSelectedSell, forKey: "isSell")
        newPostParams.updateValue(self.realEstateType.value[selectedType], forKey: "realEstateType")
        newPostParams.updateValue(self.province.value[selectedProvince].name, forKey: "provinceName")
        newPostParams.updateValue(self.province.value[selectedProvince].id, forKey: "provinceCode")
        newPostParams.updateValue(self.district.value[selectedDistrict].name, forKey: "districtName")
        newPostParams.updateValue(self.district.value[selectedDistrict].id, forKey: "districtCode")
        newPostParams.updateValue(self.ward.value[selectedWard].name, forKey: "wardName")
        newPostParams.updateValue(self.ward.value[selectedWard].id, forKey: "wardCode")
        newPostParams.updateValue(address, forKey: "address")
        newPostParams.updateValue(lat, forKey: "lat")
        newPostParams.updateValue(long, forKey: "long")
        newPostParams.updateValue(title, forKey: "title")
        newPostParams.updateValue(description, forKey: "description")
        newPostParams.updateValue(acreage, forKey: "acreage")
        newPostParams.updateValue(getAcreageRange(acreage: acreage), forKey: "acreageRange")
        newPostParams.updateValue(price, forKey: "price")
        newPostParams.updateValue(getPriceRange(price: price), forKey: "priceRange")
        newPostParams.updateValue(self.legal.value[selectedLegal], forKey: "legal")
        newPostParams.updateValue(imagesNameList, forKey: "images")
        newPostParams.updateValue(contactName, forKey: "contactName")
        newPostParams.updateValue(contactPhoneNumber, forKey: "contactPhoneNumber")
        
        if selectedProject > -1 {
            newPostParams.updateValue(project.value[selectedProject].id, forKey: "project")
            newPostParams.updateValue(project.value[selectedProject].name, forKey: "projectName")
        }
        
        if selectedFuniture > -1 {
            newPostParams.updateValue(funiture.value[selectedFuniture], forKey: "funiture")
        }
        
        if bedroom > 0 {
            newPostParams.updateValue(getBedroomRange(bedroom: bedroom), forKey: "bedroomRange")
            newPostParams.updateValue(bedroom, forKey: "bedroom")
        }
        
        if bathroom > 0 {
            newPostParams.updateValue(bathroom, forKey: "bathroom")
        }
        
        if floor > 0 {
            newPostParams.updateValue(floor, forKey: "floor")
        }
        
        if selectedHouseDirection > -1 {
            newPostParams.updateValue(houseDirection.value[selectedHouseDirection], forKey: "houseDirection")
        }
        
        if selectedBalconyDirection > -1 {
            newPostParams.updateValue(balconyDirection.value[selectedBalconyDirection], forKey: "balconyDirection")
        }
        
        if wayIn > 0 {
            newPostParams.updateValue(wayIn, forKey: "wayIn")
        }
        
        if facade > 0 {
            newPostParams.updateValue(facade, forKey: "facade")
        }
        
        return postService.addPost(params: newPostParams)
    }
    
    private func getPriceRange(price: Int) -> String {
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
    
    func getProjectByCityId() -> Observable<[Project]> {
        return projectService.findProject(params: searchProjectParams, page: nil)
    }
    
    func parseProjectArray(projects: [Project]) -> [(id: String, name: String)] {
        var projectArray = [(id: String, name: String)]()
        for (_, element) in projects.enumerated() {
            projectArray.append((id: element.id ?? "", name: element.name))
        }
        
        let sortedProject = projectArray.sorted { $0.name < $1.name }
        return sortedProject
    }
    
    func checkUpdatePost(_ realEstateType: String,
                         _ province: String,
                         _ district: String,
                         _ ward: String,
                         _ address: String,
                         _ project: String,
                         _ lat: Double,
                         _ long: Double,
                         _ title: String,
                         _ description: String,
                         _ acreage: String,
                         _ price: String,
                         _ legal: String,
                         _ funiture: String,
                         _ bedroom: String,
                         _ bathroom: String,
                         _ floor: String,
                         _ houseDirection: String,
                         _ balconyDirection: String,
                         _ wayIn: String,
                         _ facade: String,
                         _ contactName: String,
                         _ contactNumber: String) -> Bool {
        guard let post = self.post else { return false }
        var isUpdated = false
        
        /// Required Field
        if isSelectedSell != post.isSell {
            isUpdated = true
            updatePostParams.updateValue(isSelectedSell, forKey: "isSell")
        }
        
        if realEstateType != post.realEstateType {
            isUpdated = true
            updatePostParams.updateValue(realEstateType, forKey: "realEstateType")
        }
        
        if province != post.provinceName {
            isUpdated = true
            updatePostParams.updateValue(self.province.value[selectedProvince].name, forKey: "provinceName")
            updatePostParams.updateValue(self.province.value[selectedProvince].id, forKey: "provinceCode")
        }
        
        if district != post.districtName {
            isUpdated = true
            updatePostParams.updateValue(district, forKey: "districtName")
            updatePostParams.updateValue(self.district.value[selectedDistrict].id, forKey: "districtCode")
        }
        
        if ward != post.wardName {
            isUpdated = true
            updatePostParams.updateValue(ward, forKey: "wardName")
            updatePostParams.updateValue(self.ward.value[selectedWard].id, forKey: "wardCode")
        }
        
        if address != post.address {
            isUpdated = true
            updatePostParams.updateValue(address, forKey: "address")
        }
        
        if lat != post.lat {
            isUpdated = true
            updatePostParams.updateValue(lat, forKey: "lat")
        }
        
        if long != post.long {
            isUpdated = true
            updatePostParams.updateValue(long, forKey: "long")
        }
        
        if title != post.title {
            isUpdated = true
            updatePostParams.updateValue(title, forKey: "title")
        }
        
        if description != post.description {
            isUpdated = true
            updatePostParams.updateValue(description, forKey: "description")
        }
        
        
        if let parseAcreage = Double(acreage),
           parseAcreage != post.acreage {
            isUpdated = true
            updatePostParams.updateValue(parseAcreage, forKey: "acreage")
            updatePostParams.updateValue(getAcreageRange(acreage: parseAcreage), forKey: "acreageRange")
        }
        
        if let parsePrice = Int(price),
           parsePrice != post.price {
            isUpdated = true
            updatePostParams.updateValue(parsePrice, forKey: "price")
            updatePostParams.updateValue(getPriceRange(price: parsePrice), forKey: "priceRange")
        }
        
        if legal != post.legal {
            isUpdated = true
            updatePostParams.updateValue(self.legal.value[selectedLegal], forKey: "legal")
        }
        
        if contactName != post.contactName {
            isUpdated = true
            updatePostParams.updateValue(contactName, forKey: "contactName")
        }
        
        if contactNumber != post.contactPhoneNumber {
            isUpdated = true
            updatePostParams.updateValue(contactNumber, forKey: "contactNumber")
        }
        
        if imagesNameList.sorted() != post.images.sorted() {
            isUpdated = true
            updatePostParams.updateValue(imagesNameList, forKey: "images")
        }
        
        /// Non required Field
        if selectedProject > -1 {
            isUpdated = true
            updatePostParams.updateValue(self.project.value[selectedProject].name, forKey: "projectName")
            updatePostParams.updateValue(self.project.value[selectedProject].id, forKey: "project")
        }

        if selectedFuniture > -1 {
            isUpdated = true
            updatePostParams.updateValue(self.funiture.value[selectedFuniture], forKey: "funiture")
        }
        
        if let bedroom = Int(bedroom) {
            if let postBedroom = post.bedroom {
                if bedroom != postBedroom {
                    isUpdated = true
                    updatePostParams.updateValue(bedroom, forKey: "bedroom")
                    updatePostParams.updateValue(getBedroomRange(bedroom: bedroom), forKey: "bedroomRange")
                }
            } else if bedroom > 0 {
                isUpdated = true
                updatePostParams.updateValue(bedroom, forKey: "bedroom")
                updatePostParams.updateValue(getBedroomRange(bedroom: bedroom), forKey: "bedroomRange")
            }
        }
        
        if let bathroom = Int(bathroom) {
            if let postBathroom = post.bathroom {
                if bathroom != postBathroom {
                    isUpdated = true
                    updatePostParams.updateValue(bathroom, forKey: "bathroom")
                }
            } else if bathroom > 0 {
                isUpdated = true
                updatePostParams.updateValue(bathroom, forKey: "bathroom")
            }
        }
        
        if let floor = Int(floor) {
            if let postFloor = post.floor {
                if floor != postFloor {
                    isUpdated = true
                    updatePostParams.updateValue(floor, forKey: "floor")
                }
            } else if floor > 0 {
                isUpdated = true
                updatePostParams.updateValue(floor, forKey: "floor")
            }
        }
        
        if selectedHouseDirection > -1 {
            isUpdated = true
            updatePostParams.updateValue(self.houseDirection.value[selectedHouseDirection], forKey: "houseDirection")
        }
        
        if selectedBalconyDirection > -1 {
            isUpdated = true
            updatePostParams.updateValue(self.balconyDirection.value[selectedBalconyDirection], forKey: "balconyDirection")
        }
        
        if let postWayIn = post.wayIn,
           let parseWayIn = Double(wayIn),
           parseWayIn != postWayIn {
            isUpdated = true
            updatePostParams.updateValue(parseWayIn, forKey: "wayIn")
        }
           
        if let postFacade = post.facade,
           let parseFacade = Double(facade),
           parseFacade != postFacade {
            isUpdated = true
            updatePostParams.updateValue(parseFacade, forKey: "facade")
        }
        return isUpdated
    }
    
    func updatePost() -> Observable<Post> {
        return postService.updatePost(postId: post?.id ?? "", param: updatePostParams)
    }
    
    func getProvinceCoordinate(provinceName: String) -> ProvinceCoordinate {
        for (_, coordinate) in CommonConstants.coordinate.enumerated() {
            if provinceName == "Tỉnh \(coordinate.name)" {
                return coordinate
            } else {
                switch provinceName {
                case "Thành phố Cần Thơ":
                    return ProvinceCoordinate(name: "Cần Thơ", lat: 10.0653203, long: 105.5591218)
                case "Thành phố Hà Nội":
                    return ProvinceCoordinate(name: "Hà Nội", lat: 21.0031177, long: 105.8201408)
                case "Thành phố Hải Phòng":
                    return ProvinceCoordinate(name: "Hải Phòng", lat: 20.7976740, long: 106.5819789)
                case "Thành phố Hồ Chí Minh":
                    return ProvinceCoordinate(name: "Hồ Chí Minh", lat: 10.8230989, long: 106.6296638)
                case "Thành phố Đà Nẵng":
                    return ProvinceCoordinate(name: "Đà Nẵng", lat: 16.0544563, long: 108.0717219)
                default:
                    continue
                }
            }
        }
        return ProvinceCoordinate(name: "", lat: 0, long: 0)
    }
    
    func uploadImages(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        for (index, element) in imagesList.enumerated() {
            guard let data = element.pngData() else { continue }
            
            let assetDataModel = AssetDataModel(data: data, pathFile: "", thumbnail: element)
            assetDataModel.compressed = true
            assetDataModel.compressData()
            assetDataModel.remoteName = imagesNameList[index]
            
            dispatchGroup.enter()
            awsService.uploadImage(data: assetDataModel, completionHandler: { [weak self] _, error in
                guard self != nil else { return }
                if error != nil {
                    print("---------------- Lỗi upload lên AWS S3 : \(String(describing: error))----------------")
                }
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion()
        }
    }

}


