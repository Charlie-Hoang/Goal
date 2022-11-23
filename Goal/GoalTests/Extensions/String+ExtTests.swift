//
//  String+ExtTests.swift
//  GoalTests
//
//  Created by Charlie Hoang on 11/23/22.
//

import XCTest
import Goal

class String_ExtTests: XCTestCase {

    func testGToDate(){
        let dateString = "2022-04-24T18:00:00.000Z"
        let output = dateString.gToDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let expectation = formatter.date(from: "2022-04-24T18:00:00.000Z")
        XCTAssertEqual(output, expectation, "should be equal!")
    }

}
