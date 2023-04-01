//
//  DateFormatter+Ext.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 01/04/2023.
//

import Foundation

extension DateFormatter {
    static func instance(formatString: String) -> DateFormatter {
        let format = DateFormatter()
        format.dateFormat = formatString
        return format
    }
}
