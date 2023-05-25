//
//  PopUpView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-17.
//

import Foundation
import SwiftUI
import Combine

struct PopUpView: View{
    @ObservedObject var excerciseVM: ExcerciseViewModel
    
    var body: some View{
        ZStack{
            Rectangle().foregroundColor(.white).cornerRadius(10).padding(20)
            
            VStack(){
                ForEach(0..<C.ExcercisePopup.numberOfRows){ i in
                    WorkOutSetView(excerciseVM: excerciseVM, setNumber: i)
                }
                HStack{
                    Button(action: {
                        excerciseVM.closePopUp()
                    }, label: {
                        Text(Strings.Dialog.cancel)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 2))
                    })
                    .cornerRadius(25)
                    
                    Button(action: {
                        excerciseVM.completeExcercise()
                    }, label: {
                        Text(Strings.Dialog.confirm)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 2))
                    }).disabled(!excerciseVM.isValid)
                        .cornerRadius(25)
                }
            }.padding(40)
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(excerciseVM: ExcerciseViewModel())
    }
}



struct WorkOutSetView: View{
    
    @ObservedObject var excerciseVM: ExcerciseViewModel
    var setNumber: Int
    
    var body: some View{
        HStack{
            VStack(){
                if (setNumber==0){
                    Text("Sets")
                }
                TextField(excerciseVM.getLastWorkoutSets(setNumber: setNumber), text: $excerciseVM.sets[setNumber])
                    .intergerOnly(value: $excerciseVM.sets[setNumber])
                    .limitInputLength(value: $excerciseVM.sets[setNumber], length: C.ExcercisePopup.lengthOfSets)
            }
            
            VStack{
                    if (setNumber==0){
                        Text("Reps")
                    }
                TextField(excerciseVM.getLastWorkoutReps(setNumber: setNumber), text: $excerciseVM.reps[setNumber])                .intergerOnly(value: $excerciseVM.reps[setNumber])
                    .limitInputLength(value: $excerciseVM.reps[setNumber], length: C.ExcercisePopup.lengthOfReps)
            }
            
            VStack{
                
                    if (setNumber==0){
                        Text("Weight")
                    }
                TextField(excerciseVM.getLastWorkoutWeight(setNumber: setNumber), text: $excerciseVM.weight[setNumber])
                    .doubleOnly(value: $excerciseVM.weight[setNumber])
                    .limitInputLength(value: $excerciseVM.weight[setNumber], length: C.ExcercisePopup.lengthOfWeight)
            }
            
        }.background(excerciseVM.rowColor[setNumber])
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
    }
}



