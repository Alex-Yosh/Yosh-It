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
    @Binding var isShowing: Bool
    @ObservedObject var excerciseVM: ExcerciseViewModel
    
    var body: some View{
        ZStack{
            Rectangle().foregroundColor(.white).cornerRadius(10).padding(20)
            
            VStack(){
                Spacer()
                ForEach(0..<C.ExcercisePopup.numberOfRows){ i in
                    WorkOutSetView(excerciseVM: excerciseVM, setNumber: i)
                }
                Spacer()
                HStack{
                    Button(action: {
                        isShowing.toggle()
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
                        excerciseVM.completeWorkout()
                        isShowing.toggle()
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
      PopUpView(isShowing: .constant(true), excerciseVM: ExcerciseViewModel(Split: Split(name: "test")))
  }
}



struct WorkOutSetView: View{
    
    @ObservedObject var excerciseVM: ExcerciseViewModel
    var setNumber: Int
    
    var body: some View{
        HStack{
            TextField("sets", text: $excerciseVM.sets[setNumber])
                .keyboardType(.numberPad)
                .intergerOnly(value: $excerciseVM.sets[setNumber])
                .limitInputLength(value: $excerciseVM.sets[setNumber], length: 1)
                .multilineTextAlignment(.center)
            Text("x")
            
            TextField("reps", text: $excerciseVM.reps[setNumber])
                .keyboardType(.numberPad)
                .intergerOnly(value: $excerciseVM.reps[setNumber])
                .limitInputLength(value: $excerciseVM.reps[setNumber], length: 2)
                .multilineTextAlignment(.center)
            
            TextField("weight", text: $excerciseVM.weight[setNumber])
                .keyboardType(.numberPad)
                .doubleOnly(value: $excerciseVM.weight[setNumber])
                .limitInputLength(value: $excerciseVM.weight[setNumber], length: 5)
                .multilineTextAlignment(.center)
            
        }.background(excerciseVM.rowColor[setNumber])
    }
}



