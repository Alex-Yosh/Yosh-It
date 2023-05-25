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
    
    
    @Published var user: User!
    @Published var tempSplit: Split!
    var excerciseIndex: Int!
    
    @Published var isDoingExcercise = false
    @Published var isAddingDialog = false
    
    
    @Published var weight = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @Published var sets = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @Published var reps = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @Published var rowColor = [Color] (repeating: .white, count: C.ExcercisePopup.numberOfRows)
    
    @Published var isValid = false
    @Published var isListVisible = false
    @Published var isCheckmark = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    //publsiher to ensure user loaded
    private var isUserLoadedPublisher: AnyPublisher<Bool, Never>{
        $tempSplit
            .map{   i in
                i != nil
            }
            .eraseToAnyPublisher()
    }
    
    
    //publisher to ensure row is correct
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
    
    //publisher to workout is completable
    private var isWorkoutCompleteable: AnyPublisher<Bool, Never>{
        $rowColor
            .map { i in
                return !(i.contains(.red) || i == [Color](repeating: .white, count: C.ExcercisePopup.numberOfRows))
            }
            .eraseToAnyPublisher()
    }
    
    //publisher to workout is completable
    private var isSplitCompleteable: AnyPublisher<Bool, Never>{
        $tempSplit
            .map { i in
                if (i != nil){
                    for excercise in i!.excercises{
                        if (excercise.isComplete){
                            return true
                        }
                    }
                }
                return false
            }
            .eraseToAnyPublisher()
    }
    
    
    init(){
        
        if #unavailable(iOS 16.0) {
            UITableView.appearance().backgroundColor = .clear
        }
        
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
        
        isUserLoadedPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                print($0)
                self?.isListVisible = $0
            })
            .store(in: &cancellableSet)
        
        isSplitCompleteable
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.isCheckmark = $0
            })
            .store(in: &cancellableSet)
        
    }
    
    
    //adds excercise to split
    //if error, does not append. returns status as a string
    func addExcercsise(name:String) -> String{
        
        if (tempSplit.excercises.contains(where: { excercise in
            excercise.name == name
        })){
            return Strings.ExcercisePage.isAlreadyError
        }
        
        if (name == ""){
            return Strings.ExcercisePage.isEmptyError
        }
        
        let indexSplit = user.getSplitIndex(name: tempSplit.name)
        
        user.splits[indexSplit].excercises.append(Excercise(Name: name))
        tempSplit.excercises.append(Excercise(Name: name))
        return Strings.ExcercisePage.isAddedSuccessfully
    }
    
    //TODO: make arrays into Key-value, possibly more efficent?
    //completes workout by organizing and injecting workouts into excercises
    func completeExcercise(){
        moveRowsUpToEmpty()
        
        let temp = Workout(Weight: weight.map({i in
            if (i != ""){
                return Double(i)!
            }
            return 0.0
        }), Sets: sets.map({i in
            if (i != ""){
                return Int(i)!
            }
            return 0
        }), Reps: reps.map({i in
            if (i != ""){
                return Int(i)!
            }
            return 0
        }))
        
        tempSplit.excercises[excerciseIndex].workouts.append(temp)
        tempSplit.excercises[excerciseIndex].isComplete = true
        
        closePopUp()
    }
    
    //if empty row, removes it
    func moveRowsUpToEmpty(){
        var removeAt: [Int] = []
        for i in (0..<C.ExcercisePopup.numberOfRows){
            if (sets[i] == ""){
                sets.append("")
                reps.append("")
                weight.append("")
                removeAt.append(i)
            }
        }
        removeAt.reverse()
        
        for i in (0..<removeAt.count){
                sets.remove(at: removeAt[i])
                reps.remove(at: removeAt[i])
                weight.remove(at: removeAt[i])
        }
    }
    
    func completeSplit() {
        let indexSplit = user.getSplitIndex(name: tempSplit.name)
        if (isCheckmark){
            for i in (0..<tempSplit.excercises.count){
                tempSplit.excercises[i].isComplete = false
            }
        }
        for i in (0..<tempSplit.excercises.count){
            tempSplit.excercises[i].isComplete = false
        }
        user.splits[indexSplit] = tempSplit
        user.splits[indexSplit].lastDateCompleted = Date.now
    }
    
    //deletes all data about sets, reps, weight
    func closePopUp(){
        
        excerciseIndex = nil
        isDoingExcercise.toggle()
        
        weight = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
        sets = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
        reps = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
        
    }
    
    func createPopup(ExcerciseName: String){
        excerciseIndex = tempSplit.getExcerciseIndex(name: ExcerciseName)
        isDoingExcercise.toggle()
    }
    
    func getLastWorkoutSets(setNumber: Int) -> String{
        if(excerciseIndex != nil){
            if (tempSplit.excercises[excerciseIndex].workouts.count > 0){
                return String(tempSplit.excercises[excerciseIndex].lastWorkout().sets![setNumber])
            }
        }
        return "0"
        
    }
    
    func getLastWorkoutReps(setNumber: Int) -> String{
        if(excerciseIndex != nil){
            if (tempSplit.excercises[excerciseIndex].workouts.count > 0){
                return String(tempSplit.excercises[excerciseIndex].lastWorkout().reps![setNumber])
            }
        }
        
        return "0"
        
    }
    
    func getLastWorkoutWeight(setNumber: Int) -> String{
        if(excerciseIndex != nil){
            if (tempSplit.excercises[excerciseIndex].workouts.count > 0){
                return String(tempSplit.excercises[excerciseIndex].lastWorkout().weight![setNumber])
            }
        }
        
        return "0.0"
        
    }
}
