//
//  Address.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import Foundation

struct City: Codable {
    var id: String
    var name: String
}

struct District: Codable {
    var id: String
    var name: String
    var cityId: String
}

struct Ward: Codable {
    var id: String
    var name: String
    var districtId: String
}

struct Street: Codable {
    var id: String
    var name: String
    var wardId: String
}
