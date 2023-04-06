//
//   Project.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 06/04/2023.
//

import Foundation

struct Project: Codable {
    var id: String?
    var provinceCode: String
    var provinceName: String
    var districtCode: String
    var districtName: String
    var wardCode: String
    var wardName: String
    var name: String
    var price: String
    var status: String
    var lat: Double
    var long: Double
    var projectType: String
    var apartment: Int
    var acreage: Double
    var building: Int
    var legal: String
    var investor: String
    var description: String
    var images: [String]
    var posts: [String]
}
