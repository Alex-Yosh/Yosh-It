//
//  PopUpView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-17.
//

import Foundation
import SwiftUI

struct PopUpView: View{
    @Binding var isShowing: Bool
    @ObservedObject var excerciseVM: ExcerciseViewModel
    @State var weight = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @State var sets = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    @State var reps = [String] (repeating: "", count: C.ExcercisePopup.numberOfRows)
    
    var body: some View{
        ZStack{
            Rectangle().foregroundColor(.white).cornerRadius(10).padding(20)
            
            VStack(){
                Spacer()
                ForEach(0..<C.ExcercisePopup.numberOfRows){ i in
                    WorkOutSetView(weight: $weight[i], sets: $sets[i], reps: $reps[i])
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
                    })
                    .cornerRadius(25)
                }
            }.padding(40)
        }
    }
}

struct WorkOutSetView: View{
    
    @Binding var weight: String
    @Binding var sets: String
    @Binding var reps: String
    
    var body: some View{
        HStack{
            TextField("sets", text: $sets)
                .keyboardType(.numberPad)
            Text("x")
            TextField("reps", text: $reps)
                .keyboardType(.numberPad)
            TextField("weight", text: $weight)
                .keyboardType(.numberPad)
        }
    }
}


