//
//  Numeric+Ext.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 24/04/2023.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}
