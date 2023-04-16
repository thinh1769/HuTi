//
//  String+Etx.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 16/04/2023.
//

import Foundation

extension String {
    func isMatches(_ regex: String) -> Bool{
        if self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil {
            return true
        }
        return false
    }
}
