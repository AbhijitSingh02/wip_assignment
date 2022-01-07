//
//  WipNetworkManagerTests.swift
//  Wip_AssignmentTests
//
//  Created by Abhijit on 07/01/22.
//

import XCTest
@testable import Wip_Assignment

class WipNetworkManagerTests: XCTestCase {

    var nmMock: WipNetworkManager!
    override func setUpWithError() throws {
        
        nmMock = WipNetworkManager()
    }

   

    func testgetUserData_WhenWrongURLProvided() throws {
        WipNetworkManager.getUserData(urlstring: "jhsgf") { (response, error) in
            XCTAssertEqual(error, "Data not Found")
        }
    }

   
}
