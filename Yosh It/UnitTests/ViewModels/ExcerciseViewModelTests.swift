//
//  ExcerciseViewModelTests.swift
//  UnitTests
//
//  Created by Alex Yoshida on 2023-05-18.
//

import XCTest

final class ExcerciseViewModelTests: XCTestCase {
    
    private var testWeight = ["31.5", "60", "40.3", "", "", "", "", ""]
    private var testSets = ["2", "1", "3", "", "", "", "", ""]
    private var testReps = ["20", "12", "6", "", "", "", "", ""]
    
    private var testWeightDouble = [31.5, 60, 40.3, 0, 0, 0, 0, 0]
    private var testSetsInterger = [2, 1, 3, 0, 0, 0, 0, 0]
    private var testRepsInterger = [20, 12, 6, 0, 0, 0, 0, 0]
    
    
    private var sut: ExcerciseViewModel!
    
    override func setUpWithError() throws {
        sut = ExcerciseViewModel(Split: Split(name: "Test"))
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    
    func test_completeWorkout(){
        sut.weight = testWeight
        sut.sets = testSets
        sut.reps = testReps
        
        sut.split.excercises.append(Excercise(Name: "test"))
        XCTAssertNil(sut.split.excercises[0].workouts.last)
        
        sut.completeWorkout()
        
        XCTAssertNotNil(sut.split.excercises[0].workouts.last)
        
    }
    
    
    func test_wipeWorkout(){
        sut.weight = testWeight
        sut.sets = testSets
        sut.reps = testReps
        
        sut.wipeWorkout()
        XCTAssertEqual(sut.weight, [String] (repeating: "", count: C.ExcercisePopup.numberOfRows))
        XCTAssertEqual(sut.sets, [String] (repeating: "", count: C.ExcercisePopup.numberOfRows))
        XCTAssertEqual(sut.reps, [String] (repeating: "", count: C.ExcercisePopup.numberOfRows))
        
    }
    
}
