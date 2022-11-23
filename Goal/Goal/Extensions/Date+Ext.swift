//
//  Date+Ext.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import Foundation

public extension Date{
    func gToDateString() -> String?{
        let dateString = toString(format: "yyyy-MM-dd")
        let todayString = Date().toString(format: "yyyy-MM-dd")
        if dateString == todayString{
            return "Today"
        }
        return dateString
    }
    func gToTimeString() -> String?{
        toString(format: "HH:mm:ss")
    }
    private func toString(format: String) -> String?{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "UTC") 
        return formatter.string(from: self)
    }
}
