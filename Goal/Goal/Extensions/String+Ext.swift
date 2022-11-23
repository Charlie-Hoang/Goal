//
//  String+Ext.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import Foundation

public extension String{
    func gToDate() -> Date?{
        toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
    private func toDate(format: String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "UTC") 
        return formatter.date(from: self)
    }
}
