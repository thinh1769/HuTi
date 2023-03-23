//
//  CommonConstants.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 10/03/2023.
//

import Foundation

struct CommonConstants {
    static let tableRowHeight = 130.0
    static let phoneNumber = "Số điện thoại"
    static let password = "Mật khẩu"
    static let confirmPassword = "Xác nhận mật khẩu"
    static let notSignIn = "Bạn chưa đăng nhập hoặc đăng ký?"
    static let done = "Xong"
    static let cancel = "Thoát"
}

struct TextFieldPlaceHolder {
    static let typeRealEstate = "Loại nhà đất"
    static let typeProject = "Loại dự án"
    static let city = "Tỉnh, thành phố"
    static let district = "Quận, huyện"
    static let ward = "Phường, xã"
    static let street = "Đường phố"
    static let price = "Mức giá"
    static let acreage = "Diện tích"
    static let legal = "Giấy tờ pháp lý"
    static let funiture = "Nội thất"
    static let houseDirection = "Hướng nhà"
    static let balconyDirection = "Hướng ban công"
}

struct PickerTag {
    static let type = 0
    static let city = 1
    static let district = 2
    static let ward = 3
    static let project = 4
    static let price = 5
    static let acreage = 6
    static let legal = 7
    static let funiture = 8
    static let houseDirection = 9
    static let balconyDirection = 10
    static let bedroom = 11
    static let status = 12
}

struct ImageName {
    static let house = "house"
    static let project = "project"
    static let user = "user"
    static let list = "list"
    static let map = "map"
    static let backButton = "chevron.left"
    static let circle = "circle"
    static let checkmarkFill = "checkmark.circle.fill"
 }

struct ColorName {
    static let background = "background"
    static let themeText = "themeText"
    static let otpBackground = "otpBackground"
    static let gray = "gray"
    static let white = "white"
    static let black = "black"
    static let red = "red"
}

struct TabBarItemTitle {
    static let sell = "Bán"
    static let forRent = "Cho thuê"
    static let project = "Dự án"
    static let account = "Tài khoản"
}
    
struct ClassNibName {
    static let FilterResultViewController = "FilterResultViewController"
    static let FilterViewController = "FilterViewController"
    static let PostedViewController = "PostedViewController"
}

struct MainTitle {
    static let sell = "Nhà đất bán"
    static let forRent = "Nhà đất cho thuê"
    static let project = "Dự án"
    static let postedPosts = "Các tin đã đăng"
    static let favoritePosts = "Tin đăng yêu thích"
}

struct TypeRealEstate {
    static let sell = [Self.apartment, Self.home, Self.villa, Self.streetHouse, Self.shopHouse, Self.projectLand, Self.land, Self.farmResort]
    static let forRent = [Self.apartment, Self.home, Self.villa, Self.streetHouse, Self.shopHouse, Self.motel, Self.office, Self.shopKiosk, Self.wareHouseFactory, Self.land, Self.otherRealEstate]
    
    static let apartment = "Căn hộ chung cư"
    static let home = "Nhà riêng"
    static let villa = "Nhà biệt thự, liền kề"
    static let streetHouse = "Nhà mặt phố"
    static let shopHouse = "Nhà phố thương mại"
    static let projectLand = "Đất nền dự án"
    static let land = "Đất"
    static let farmResort = "Trang trại, khu nghỉ dưỡng"
    static let motel = "Nhà trọ, phòng trọ"
    static let office = "Văn phòng"
    static let shopKiosk = "Cửa hàng, kiot"
    static let wareHouseFactory = "Kho, nhà xưởng"
    static let otherRealEstate = "Bất động sản khác"
}

enum AdministrativeURLType: String {
    case getAllProvinces
    case getDistrictsByProvince
    case getWardsByDistrict
}

struct AdministrativeURL {
    static let getAllProvinces = "https://vn-public-apis.fpo.vn/provinces/getAll?limit=-1"
    static let getDistrictsByProvince = "https://vn-public-apis.fpo.vn/districts/getByProvince?provinceCode="
    static let getWardsByDistrict = "https://vn-public-apis.fpo.vn/wards/getByDistrict?districtCode="
    static let urlTail = "&limit=-1"
}
