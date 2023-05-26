//
//  Split.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-12.
//

import Foundation
import Combine


struct Split: Identifiable{
    internal var id = UUID()
    var name: String
    var excercises: [Excercise]
    var previousDates: [Date]
    var lastTotalWeight: Double
    var lastTotalReps: Int
    var lastTotalSets: Int
    
    
    
    init(name: String) {
        self.name = name
        excercises = []
        lastTotalSets = 0
        lastTotalReps = 0
        lastTotalWeight = 0.0
        previousDates = []
        
    }
    
    func getExcerciseIndex(name: String) -> Int{
        for i in (0..<excercises.count){
            if (excercises[i].name == name){
                return i
            }
        }
        return -1
    }
    
    //returns error if split hasnt been completed yet
    func getLastDateCompleted() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d y"
        return formatter.string(from: previousDates[0])
    }
    
}
