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
    
    
    @Published var weight = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @Published var sets = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @Published var reps = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)

    
    
//    private var lastSplitPublisher: AnyPublisher<Split, Never>{
//
//    }
    
    init(Split: Split){
        split = Split
    }
    
    
    //adds excercise to split
    //if error, does not append. returns status as a string
    func addExcercsise(name:String) -> String{
        
        if (split.excercises.contains(where: { excercise in
            excercise.name == name
        })){
            return Strings.ExcercisePage.isAlreadyError
        }
        
        if (name == ""){
            return Strings.ExcercisePage.isEmptyError
        }
        
        
        split.excercises.append(Excercise(Name: name))
        return Strings.ExcercisePage.isAddedSuccessfully
    }
    
    //gets previous split given excercise
    func getLastWorkOut(excercise:Excercise) -> Workout{
        return Workout()
    }
    
    //completes workout by injecting workouts into excercises
    func completeWorkout(){
        
    }
}
