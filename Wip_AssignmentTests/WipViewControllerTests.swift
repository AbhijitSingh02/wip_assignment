//
//  WipViewControllerTests.swift
//  Wip_AssignmentTests
//
//  Created by Abhijit on 06/01/22.
//

import XCTest
@testable import Wip_Assignment

class WipViewControllerTests: XCTestCase {

    var wipVC: WipViewController?
    var vmmock: WipViewModelMock?
    override func setUpWithError() throws {
        vmmock = WipViewModelMock()

        wipVC = WipViewController()
        wipVC?.viewModel = vmmock ?? WipViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDataCalled_WhenviewDidloadCalleds() {
        
        XCTAssertTrue(vmmock?.getDataCalled ?? false)
    }
    
    
    

    func testNumberofrows_whenMockDataProvided() {
        vmmock?.contactApiData = WipModel(title: "abc", rows: [Row(title: "first", rowDescription: "desc", imageHref: "")])
        let numberOfRows = wipVC?.tableView(wipVC?.contactsTableView ?? UITableView()
                                          , numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func testCellHeight() {
        let height = wipVC?.tableView(wipVC?.contactsTableView ?? UITableView(), heightForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(height, 50)
    }
}
class WipViewModelMock: WipViewModel {
    var getDataCalled = false
    override func getData() {
        getDataCalled = true
    }
}
