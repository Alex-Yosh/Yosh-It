//
//  ResistanceViewModelTests.swift
//  ResistanceViewModelTests
//
//  Created by Alex Yoshida on 2023-05-15.
//

import XCTest

final class ResistanceViewModelTests: XCTestCase {
    private var sut: ResistanceViewModel!

    override func setUpWithError() throws {
        sut = ResistanceViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    
    func test_addSplit_isAlreadyError(){
        sut.addSplit(name: "d")
        let actual = sut.addSplit(name: "d")
        let expected = Strings.ResistancePage.isAlreadyError
        
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(sut.splits.count, 1)
    }
    
    func test_addSplit_isEmptyError(){
        let actual = sut.addSplit(name: "")
        let expected = Strings.ResistancePage.isEmptyError
        
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(sut.splits.count, 0)
    }
    
    func test_addSplit_isSuccessful(){
        let actual = sut.addSplit(name: "d")
        let expected = Strings.ResistancePage.isAddedSuccessfully
        
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(sut.splits.count, 1)
    }

}
