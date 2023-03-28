//
//  ResponseMain.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 22/03/2023.
//

import Foundation

class ResponseMain<Payload: Codable>: Codable {
    var status: Int
    var message: String
    var payload: Payload? = nil
}
