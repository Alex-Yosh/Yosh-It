//
//  SplitTests.swift
//  UnitTests
//
//  Created by Alex Yoshida on 2023-05-15.
//

import XCTest

final class SplitTests: XCTestCase {

    private var sut: Split!
    
    override func setUpWithError() throws {
        sut = Split()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

}
