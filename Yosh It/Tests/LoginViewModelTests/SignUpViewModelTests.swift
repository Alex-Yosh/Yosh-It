//
//  SignUpViewModelTests.swift
//  SignUpViewModelTests
//
//  Created by Alex Yoshida on 2023-05-15.
//

import XCTest
import Combine

final class SignUpViewModelTests: XCTestCase {
    private var sut: SignUpViewModel!
    
    override func setUpWithError() throws {
        sut = SignUpViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    //USERNAME TESTS
    
    func test_isUsernameValidPublisher(){
        sut.username = "tootoolong!"
        sut.isUsernameValidPublisher.sink(receiveValue: { value in
            XCTAssertTrue(value.contains(Strings.SignUpPage.isTooLongUsername))
        })
        
        sut.username = "short"
        sut.isUsernameValidPublisher.sink(receiveValue: { value in
            XCTAssertTrue(value.contains(Strings.SignUpPage.isNotLongEnoughUsername))
        })
        
    }
    
    
    //PASSWORD TESTS
    
    func test_isPasswordValidPublisher(){
        sut.password = "tootoolong!"
        sut.isPasswordValidPublisher.sink(receiveValue: { value in
            XCTAssertTrue(value.contains(Strings.SignUpPage.isTooLongPassword))
        })
        
        sut.password = "short"
        sut.isPasswordValidPublisher.sink(receiveValue: { value in
            XCTAssertTrue(value.contains(Strings.SignUpPage.isNotLongEnoughPassword))
            XCTAssertTrue(value.contains(Strings.SignUpPage.isNotEqualPassword))
        })
        
        sut.passwordAgain = "short"
        sut.isPasswordValidPublisher.sink(receiveValue: { value in
            XCTAssertFalse(value.contains(Strings.SignUpPage.isNotEqualPassword))
        })
        
    }
}
