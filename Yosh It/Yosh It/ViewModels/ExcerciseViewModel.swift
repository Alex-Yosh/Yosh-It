//
//  ExcerciseViewModel.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation
import Combine

class ExcerciseViewModel: ObservableObject{
    
    @Published var split: Split
    
//    private var lastSplitPublisher: AnyPublisher<Split, Never>{
//
//    }
    
    init(Split: Split){
        split = Split
    }
    
    
    //adds excercise to split
    func addExcercsise(excercise:Excercise){
        split.excercises.append(excercise)
    }
    
    //gets previous split given excercise
    func getLastWorkOut(excercise:Excercise) -> Workout{
        return Workout()
    }
    
    //completes workout by injecting workouts into excercises
    func completeWorkout(){
        
    }
}
