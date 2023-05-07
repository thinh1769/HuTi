//
//  User.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 26/03/2023.
//

import Foundation

struct User: Codable {
    var id: String?
    var name: String?
    var phoneNumber: String?
    var password: String?
    var email: String
    var dateOfBirth: String?
    var gender: String?
    var identityCardNumber: String?
    var likePosts: [String]?
    var isAdmin: Bool?
    var token: String?
}
