//
//  ExcerciseViewModelTests.swift
//  UnitTests
//
//  Created by Alex Yoshida on 2023-05-18.
//

import XCTest

final class ExcerciseViewModelTests: XCTestCase {
    let user = User.userObj
    
    private var testWeight = ["31.5", "60", "40.3", "", "", "", "", ""]
    private var testSets = ["2", "1", "3", "", "", "", "", ""]
    private var testReps = ["20", "12", "6", "", "", "", "", ""]
    
    private var testWeightDouble = [31.5, 60, 40.3, 0, 0, 0, 0, 0]
    private var testSetsInterger = [2, 1, 3, 0, 0, 0, 0, 0]
    private var testRepsInterger = [20, 12, 6, 0, 0, 0, 0, 0]
    
    
    private var sut: ExcerciseViewModel!
    
    override func setUpWithError() throws {
        sut = ExcerciseViewModel()
        sut.user = user
        sut.user.splits.append(Split(name: "TestSplit"))
    }
    
    override func tearDownWithError() throws {
        sut = nil
        user.splits = []
    }
    
    
    func test_completeWorkout(){
        sut.weight = testWeight
        sut.sets = testSets
        sut.reps = testReps
        
        let splitIndex = user.getSplitIndex(name: "TestSplit")
        
        sut.user.splits[splitIndex].excercises.append(Excercise(Name: "TestExcercise"))
        XCTAssertNil(sut.user.splits[splitIndex].excercises[0].workouts.last)
        
        sut.completeWorkout(SplitName: "TestSplit", ExcerciseName: "TestExcercise")
        
        XCTAssertNotNil(sut.user.splits[splitIndex].excercises[0].workouts.last)
        
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
