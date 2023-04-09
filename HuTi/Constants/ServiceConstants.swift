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
    static let NOT_FOUND = 404
    static let SERVER_ERROR = 500
}

struct Base {
    static let URL = "http://192.168.2.9:3000/api/"
//    static let URL = "http://172.20.10.3:3000/api/"
//    static let URL = "http://localhost:3000/api/"
}

enum APIConstants: String {
    case signIn = "user/signin"
    case sendOTP = "user/send-otp-for-register"
    case sendOTPResetPassword = "user/send-otp-for-reset-password"
    case register = "user/register"
    case resetPassword = "user/reset-password"
    case confirmOTP = "user/confirm-otp"
    case updateInfo = "user/update-info" 
    case getAllProvinces = "province"
    case getDistrictsByProvinceId = "district/p"
    case getWardsByDistrictId = "ward/d"
    case addNewPost = "post/add-post"
    case getPosts = "post/get-post"
    case getPostById = "post/get-post-by-id/"
    case findPost = "post/find"
    case findProject = "project/find"
    case getProject = "project"
    case getProjectById = "project/"
    
    var method: HTTPMethodSupport {
        switch self {
        case .signIn:
            return .post
        case .sendOTP:
            return .post
        case .sendOTPResetPassword:
            return .post
        case .register:
            return .post
        case .resetPassword:
            return .put
        case .confirmOTP:
            return .post
        case .updateInfo:
            return .put
        case .getAllProvinces:
            return .get
        case .getDistrictsByProvinceId:
            return .get
        case .getWardsByDistrictId:
            return .get
        case .addNewPost:
            return .post
        case .getPosts:
            return .post
        case .getPostById:
            return .get
        case .findPost:
            return .post
        case .findProject:
            return .post
        case .getProject:
            return .get
        case .getProjectById:
            return .get
        }
    }
}

enum ServiceError: Error {
    case network
    case badRequest(message: String)
    case unauthorized(message: String)
    case serverError(message: String)
    case unknown(message: String)
    case emptyResponse(message: String)
    case invalidMethod
    
    func get() -> String {
        switch self {
        case .network:
            return CommonConstants.networkError
        case .badRequest(let message):
            return message
        case .unauthorized(let message):
            return message
        case .serverError(let message):
            return message
        case .unknown(let message):
            return message
        case .emptyResponse(let message):
            return message
        case .invalidMethod:
            return CommonConstants.networkError
        }
    }
}

struct AWSConstants {
    static let accessKey = "AKIA4SZBYIUOX2L46WOP"
    static let secretKey = "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"
    static let s3Bucket = "huti-kltn"
}
