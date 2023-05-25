//
//  Excercise.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation

struct Excercise: Identifiable{
    internal var id = UUID()
    var name: String
    private var lastDate: String?
    var workouts: [Workout]
    var date: String?
    private var prOne: Double?
    private var prThree: Double?
    private var prSix: Double?
    
    //for excerciseVM to see its been completed in a workout
    var isComplete: Bool = false
    
    
    init(Name: String){
        name = Name
        workouts = [Workout]()
    }
    
    //assumes there is a workout, else our of range error
    func lastWorkout()-> Workout{
        return workouts[workouts.count-1]
    }
    
}
