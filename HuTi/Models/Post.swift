//
//  Post.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import Foundation

struct Post: Codable {
    var id: String?
    var title: String
    var price: Double
    var address: String
    var provinceCode: String
    var provinceName: String
    var districtCode: String
    var districtName: String
    var wardCode: String
    var wardName: String
    var lat: Double
    var long: Double
    var userId: String
    var userName: String
    var createdAt: Double
    var thumbnail: String /// lấy image đầu tiên trong mảng images
}

struct PostDetail: Codable {
    var id: String?
    var userId: String?
    var isSell: Bool
    var realEstateType: String
    var provinceCode: String
    var districtCode: String
    var wardCode: String
    var provinceName: String
    var districtName : String
    var wardName: String
    var address: String
    var projectId: String?
    var lat: Double
    var long: Double
    var title: String
    var description: String
    var acreage: Double
    var acreageRange: String?
    var price: Double
    var priceRange: String?
    var legal: String
    var funiture: String
    var bedroom: Int
    var bathroom: Int
    var floor: Int
    var houseDirection: String
    var balconyDirection: String
    var wayIn: Double
    var facade: Double
    var images: [String]
    var username: String?
    var contactName: String?
    var contactPhoneNumber: String?
}

