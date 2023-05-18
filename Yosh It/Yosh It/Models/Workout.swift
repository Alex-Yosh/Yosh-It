//
//  Workout.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation

struct Workout{
    var date: String?
    var sets: [Int]?
    var reps: [Int]?
    var weight: [Double]?
    
    init(){
        
    }
    
    init(Weight: [Double], Sets: [Int], Reps: [Int]){
        weight = Weight
        sets = Sets
        reps = Reps
    }
}
