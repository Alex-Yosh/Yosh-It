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
                                if(excerciseVM.isCheckmark){
                                    excerciseVM.completeSplit()
                                }
                            }, label: {
                                ZStack{
                                    Circle().frame(width: 100, height: 100, alignment: .bottomTrailing)
                                        .foregroundColor(excerciseVM.isCheckmark ? .green.opacity(60): .red.opacity(60))
                                    Image(systemName: excerciseVM.isCheckmark ? "checkmark.circle" : "x.circle")
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
                            })
                        }
                    }.padding()
                }.excerciseTextFieldAlert(excerciseVM: excerciseVM)
            }
            
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
