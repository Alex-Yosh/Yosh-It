//
//  ExcerciseView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation
import SwiftUI

struct ExcerciseView: View {
    
    @EnvironmentObject var user: User
    var SplitName: String
    @StateObject var excerciseVM = ExcerciseViewModel()
    @State private var isAdding = false
    @State private var isError = false
    @State private var name = ""
    @State private var errorMessage = ""
    
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                TopBarView(title: SplitName)
                
                ZStack{
                    ExcerciseListView(SplitName: SplitName, excerciseVM: excerciseVM)
                    
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
                                    errorMessage = excerciseVM.addExcercsise(name: name, SplitName: SplitName)
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
            
            if(excerciseVM.isAddingWorkout){
                GeometryReader { _ in
                    
                    PopUpView(excerciseVM: excerciseVM)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 35)
                }
                .background(
                    Color.black.opacity(0.20)
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }.onAppear(perform: {
            excerciseVM.user = user
        })
    }
}


struct ExcerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExcerciseView(SplitName: "test")
    }
}
