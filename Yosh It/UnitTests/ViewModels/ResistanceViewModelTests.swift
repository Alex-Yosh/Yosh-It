//
//  ResistanceViewModelTests.swift
//  ResistanceViewModelTests
//
//  Created by Alex Yoshida on 2023-05-15.
//

import XCTest

final class ResistanceViewModelTests: XCTestCase {
    private var sut: ResistanceViewModel!
    let user = User.userObj

    override func setUpWithError() throws {
        sut = ResistanceViewModel()
        sut.user = user
    }

    override func tearDownWithError() throws {
        sut = nil
        user.splits = []
    }

    
    func test_addSplit_isAlreadyError(){
        sut.addSplit(name: "d")
        let actual = sut.addSplit(name: "d")
        let expected = Strings.ResistancePage.isAlreadyError
        
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(sut.user.splits.count, 1)
    }
    
    func test_addSplit_isEmptyError(){
        let actual = sut.addSplit(name: "")
        let expected = Strings.ResistancePage.isEmptyError
        
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(sut.user.splits.count, 0)
    }
    
    func test_addSplit_isSuccessful(){
        let actual = sut.addSplit(name: "d")
        let expected = Strings.ResistancePage.isAddedSuccessfully
        
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(sut.user.splits.count, 1)
    }

}
