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
    static let URL = "http://192.168.2.8:3000/api/"
}

enum APIConstants: String {
    case signIn = "user/signin"
    case sendOTP = "user/send-otp"
    case register = "user/register"
    case confirmOTP = "user/confirm-otp"
    case updateInfo = "user/" /// { id }
    case getAllCities = "city"
    case getDistrictsByCityId = "district/" /// { id }
    case getWardsByDistrictId = "ward/" /// { id }
    
    var method: HTTPMethodSupport {
        switch self {
        case .signIn:
            return .post
        case .sendOTP:
            return .post
        case .register:
            return .post
        case .confirmOTP:
            return .post
        case .updateInfo:
            return .put
        case .getAllCities:
            return .get
        case .getDistrictsByCityId:
            return .get
        case .getWardsByDistrictId:
            return .get
        }
    }
}
