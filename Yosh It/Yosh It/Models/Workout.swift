//
//  Workout.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation

struct Workout{
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
    
    func getTotalSets() -> Int{
        var total = 0
        for i in sets!{
            total += i
        }
        return total
    }
    
    func getTotalReps() -> Int{
        var total = 0
        for i in reps!{
            total += i
        }
        return total
    }
    
    func getTotalWeight() -> Double{
        var total = 0.0
        for i in 0...(sets!.count-1){
            total += weight![i]*Double(reps![i]*sets![i])
        }
        return total
    }
}
