//
//  LoginViewModelTests.swift
//  LoginViewModelTests
//
//  Created by Alex Yoshida on 2023-05-15.
//

import XCTest

final class LoginViewModelTests: XCTestCase {
    private var sut: LoginViewModel!
    
    override func setUpWithError() throws {
        sut = LoginViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

}
