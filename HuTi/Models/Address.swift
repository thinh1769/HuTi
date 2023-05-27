//
//  Address.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import Foundation

struct Province: Codable {
    var id: String
    var idProvince: String
    var name: String
}

struct District: Codable {
    var id: String
    var idProvince: String
    var idDistrict: String
    var name: String
}

struct Ward: Codable {
    var id: String
    var idDistrict: String
    var idWard: String
    var name: String
}

struct ProvinceCoordinate {
    var name: String
    var lat: Double
    var long: Double
}

