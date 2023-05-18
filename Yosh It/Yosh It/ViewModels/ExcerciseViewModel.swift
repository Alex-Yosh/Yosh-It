//
//  ExcerciseViewModel.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation
import Combine
import SwiftUI

class ExcerciseViewModel: ObservableObject{
    
    @Published var split: Split
    
    
    @Published var weight = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @Published var sets = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @Published var reps = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @Published var rowColor = [Color] (repeating: .white, count: C.ExcercisePopup.numberOfRows)

    @Published var isValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    //publisher to ensure password's are equal
    private var isRowCorrect: AnyPublisher<[Color], Never>{
        Publishers.CombineLatest3($weight, $sets, $reps)
              .map { weight, sets, reps in
                  var temp = [Color](repeating: .white, count: C.ExcercisePopup.numberOfRows)
                  for i in 0..<C.ExcercisePopup.numberOfRows{
                      let weightIndex = weight[i].filter { "123456789.".contains($0) }
                      let setIndex = sets[i].filter { "123456789.".contains($0) }
                      let repIndex = reps[i].filter { "123456789.".contains($0) }
                      
                      if (weightIndex != "" && setIndex != "" && repIndex != "" && weightIndex != "." && weightIndex != ".."){
                          temp[i] = .green
                      }
                      else if (weightIndex != "" || setIndex != "" || repIndex != ""){
                          temp[i] = .red
                      }
                  }
                  return temp
              }
              .eraseToAnyPublisher()
    }
    
    //publisher to ensure password's are equal
    private var isWorkoutCompleteable: AnyPublisher<Bool, Never>{
            $rowColor
              .map { i in
                  return !(i.contains(.red) || i == [Color](repeating: .white, count: C.ExcercisePopup.numberOfRows))
              }
              .eraseToAnyPublisher()
    }
    
    
    init(Split: Split){
        split = Split
        
        isWorkoutCompleteable
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.isValid = $0
            })
            .store(in: &cancellableSet)
        
        isRowCorrect
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.rowColor = $0
            })
            .store(in: &cancellableSet)
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
