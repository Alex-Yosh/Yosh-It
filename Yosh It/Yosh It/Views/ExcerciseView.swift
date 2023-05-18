//
//  ExcerciseView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation
import SwiftUI

struct ExcerciseView: View {
    
    @ObservedObject var excerciseVM: ExcerciseViewModel
    @State private var isAdding = false
    @State private var isError = false
    @State private var name = ""
    @State private var errorMessage = ""
    @State private var isAddingWorkout = false
    
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                TopBarView(title: excerciseVM.split.name)
                
                ZStack{
                    ExcerciseListView(excerciseVM: excerciseVM, isAddingWorkout: $isAddingWorkout)
                    
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                isAdding.toggle()
                            }, label: {
                                ZStack{
                                    Circle().frame(width: 100, height: 100, alignment: .bottomTrailing)
                                        .foregroundColor(CustomColours.FaintIndigo)
                                    Image(systemName: "plus")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 60, height: 60, alignment: .bottomTrailing)
                                }
                            }).alert(Strings.Dialog.titleNewSplit, isPresented: $isAdding) {
                                TextField(Strings.Dialog.textFieldNewSplit, text: $name)
                                    .textInputAutocapitalization(.never)
                                Button(Strings.Dialog.confirm){
                                    errorMessage = excerciseVM.addExcercsise(name: name)
                                    if (errorMessage != Strings.ExcercisePage.isAddedSuccessfully)
                                    {
                                        isError.toggle()
                                    }
                                    name = ""
                                }
                                Button(Strings.Dialog.cancel, role: .cancel) { name = ""}
                            }message: {
                                Text(Strings.Dialog.messageNewSplitEnterName)
                            }
                            .alert(Strings.Dialog.titleError, isPresented: $isError){
                                EmptyView()
                            }message: {
                                Text(errorMessage)
                            }
                        }
                    }.padding(.trailing).padding(.bottom)
                }
            }.edgesIgnoringSafeArea(.bottom)
            
            if(isAddingWorkout){
                GeometryReader { _ in
                    
                    PopUpView(isShowing: $isAddingWorkout, excerciseVM: excerciseVM)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 35)
                }
                .background(
                    Color.black.opacity(0.20)
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }
    }
}


struct ExcerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExcerciseView(excerciseVM: ExcerciseViewModel(Split: Split(name: "test")))
    }
}
