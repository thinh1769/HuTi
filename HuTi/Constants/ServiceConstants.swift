//
//  ServiceConstants.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 26/03/2023.
//

import Foundation

enum HTTPMethodSupport: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct StatusCode {
    static let OK = 200
    static let BAD_REQUEST = 400
    static let UNAUTHORIZED = 401
    static let SERVER_ERROR = 500
}

struct Base {
    static let URL = "http://172.20.10.3:3000/api/"
}

enum APIConstants: String {
    case signIn = "user/signin"
    case register = "user/register"
    case getAllCities = "city"
    case getDistrictsByCityId = "district/" /// { id }
    case getWardsByDistrictId = "ward/" /// { id }
    
    var method: HTTPMethodSupport {
        switch self {
        case .signIn:
            return .post
        case .register:
            return .post
        case .getAllCities:
            return .get
        case .getDistrictsByCityId:
            return .get
        case .getWardsByDistrictId:
            return .get
        }
    }
}
