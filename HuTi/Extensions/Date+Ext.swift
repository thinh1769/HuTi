//
//  Date+Ext.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 06/05/2023.
//

import Foundation

extension Date {
    func getMaximumDate() -> Date {
        let date = Date()
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        
        let calendar = Calendar.current
        let components = DateComponents(year: year - 18, month: month, day: day)
        if let maximumDate = calendar.date(from: components) {
            return maximumDate
        } else {
            return Date()
        }
    }
    
    func getMinimumDate() -> Date {
        let date = Date()
        
        let calendar = Calendar.current
        let components = DateComponents(year: 1900, month: 1, day: 1)
        if let minimum = calendar.date(from: components) {
            return minimum
        } else {
            return Date()
        }
    }
}
