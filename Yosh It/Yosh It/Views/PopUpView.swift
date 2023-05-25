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
            Rectangle().foregroundColor(.white).cornerRadius(10).padding(20).padding(.vertical, 15)
            
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
                            .background(CustomColours.MainIndigo)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                        
                    })
                    
                    Button(action: {
                        excerciseVM.completeExcercise()
                    }, label: {
                        Text(Strings.Dialog.confirm)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .background(excerciseVM.isValid ? CustomColours.MainIndigo: CustomColours.FaintIndigo)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }).disabled(!excerciseVM.isValid)
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
        HStack(spacing: 0){
            VStack(){
                if (setNumber==0){
                    Text("Sets")
                }
                TextField("", text: $excerciseVM.sets[setNumber]).placeholder(when: excerciseVM.sets[setNumber].isEmpty, alignment: .center) {
                    Text(excerciseVM.getLastWorkoutSets(setNumber: setNumber)).foregroundColor(.gray)
                }
                .intergerOnly(value: $excerciseVM.sets[setNumber])
                .limitInputLength(value: $excerciseVM.sets[setNumber], length: C.ExcercisePopup.lengthOfSets)
                .background(excerciseVM.rowColor[setNumber])
                .keyboardType(.numberPad)
            }
            
            VStack{
                if (setNumber==0){
                    Text("Reps")
                }
                TextField("", text: $excerciseVM.reps[setNumber]).placeholder(when: excerciseVM.reps[setNumber].isEmpty, alignment: .center) {
                    Text(excerciseVM.getLastWorkoutReps(setNumber: setNumber)).foregroundColor(.gray)
                }                .intergerOnly(value: $excerciseVM.reps[setNumber])
                    .limitInputLength(value: $excerciseVM.reps[setNumber], length: C.ExcercisePopup.lengthOfReps).background(excerciseVM.rowColor[setNumber])
                    .keyboardType(.numberPad)
            }
            
            VStack{
                
                if (setNumber==0){
                    Text("Weight")
                }
                TextField("" , text: $excerciseVM.weight[setNumber]).placeholder(when: excerciseVM.weight[setNumber].isEmpty, alignment: .center) {
                    Text(excerciseVM.getLastWorkoutWeight(setNumber: setNumber)).foregroundColor(.gray)
                        .doubleOnly(value: $excerciseVM.weight[setNumber])
                        .limitInputLength(value: $excerciseVM.weight[setNumber], length: C.ExcercisePopup.lengthOfWeight)
                }.background(excerciseVM.rowColor[setNumber])
                    .keyboardType(.decimalPad)
            }
        }
        .foregroundColor(.black)
        .multilineTextAlignment(.center)
    }
}



