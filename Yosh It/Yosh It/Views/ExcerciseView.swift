//
//  ExcerciseView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation
import SwiftUI

struct ExcerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var user: User
    var SplitName: String
    @StateObject var excerciseVM = ExcerciseViewModel()
    @State private var name = ""
    @State private var errorMessage = ""
    
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                TopBarView(title: SplitName)
                
                ZStack{
                    if(excerciseVM.isListVisible){
                        ExcerciseListView(excerciseVM: excerciseVM)
                    }
                    
                    VStack{
                        Spacer()
                        HStack{
                            Button(action: {
                                dismiss()
                                excerciseVM.completeSplit()
                            }, label: {
                                ZStack{
                                    Circle().frame(width: 100, height: 100, alignment: .bottomTrailing)
                                        .foregroundColor(.green.opacity(60))
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 60, height: 60, alignment: .bottomTrailing)
                                }
                            })
                            Spacer()
                            Button(action: {
                                excerciseVM.isAddingDialog.toggle()
                            }, label: {
                                ZStack{
                                    Circle().frame(width: 100, height: 100, alignment: .bottomTrailing)
                                        .foregroundColor(CustomColours.FaintIndigo)
                                    Image(systemName: "plus")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 60, height: 60, alignment: .bottomTrailing)
                                }
                            }).alert(Strings.Dialog.titleNewSplit, isPresented: $excerciseVM.isAddingDialog) {
                                TextField(Strings.Dialog.textFieldNewSplit, text: $name)
                                    .textInputAutocapitalization(.never)
                                Button(Strings.Dialog.confirm){
                                    errorMessage = excerciseVM.addExcercsise(name: name)
                                    if (errorMessage != Strings.ExcercisePage.isAddedSuccessfully)
                                    {
                                        excerciseVM.isErrorDialog.toggle()
                                    }
                                    name = ""
                                }
                                Button(Strings.Dialog.cancel, role: .cancel) { name = ""}
                            }message: {
                                Text(Strings.Dialog.messageNewSplitEnterName)
                            }
                            .alert(Strings.Dialog.titleError, isPresented: $excerciseVM.isErrorDialog){
                                EmptyView()
                            }message: {
                                Text(errorMessage)
                            }
                        }
                    }.padding()
                }
            }.edgesIgnoringSafeArea(.bottom)
            
            if(excerciseVM.isDoingExcercise){
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
            let indexSplit = user.getSplitIndex(name: SplitName)
            excerciseVM.user = user
            excerciseVM.tempSplit = user.splits[indexSplit]
        }).navigationBarHidden(true)
    }
}
