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
//    var description: String
//    var type: Int
//    var city: City
//    var district: District
//    var ward: Ward
//    var street: Street
    var address: String
//    var projectId: String
//    var lat: Double
//    var long: Double
//    var acreage: String
    var price: String
//    var legelDocument: Int
//    var funiture: Int
//    var bedroom: Int
//    var bathroom: Int
//    var houseDirection: Int
//    var balconyDirection: Int
//    var image: [String]
    var authorName: String
//    var authorPhoneNumber: String
}
