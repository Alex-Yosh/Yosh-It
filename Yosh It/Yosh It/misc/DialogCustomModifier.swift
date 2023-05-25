//
//  DialogCustomModifier.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-24.
//

import Foundation
import SwiftUI

struct TextFieldAlertResistance: ViewModifier {
    @ObservedObject var ResistanceVM: ResistanceViewModel
    @State var name = ""
    @State var errorMessage: String = ""
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.alert(Strings.Dialog.titleNewSplit, isPresented: $ResistanceVM.isAddingDialog) {
                TextField(Strings.Dialog.textFieldNewName, text: $name)
                    .textInputAutocapitalization(.never)
                Button(Strings.Dialog.confirm){
                    errorMessage = ResistanceVM.addSplit(name: name)
                    if (errorMessage != Strings.ResistancePage.isAddedSuccessfully)
                    {
                        ResistanceVM.isErrorDialog.toggle()
                    }
                    name = ""
                }
                Button(Strings.Dialog.cancel, role: .cancel) { name = ""}
            }message: {
                Text(Strings.Dialog.messageNewSplitEnterName)
            }
            .alert(Strings.Dialog.titleError, isPresented: $ResistanceVM.isErrorDialog){
                EmptyView()
            }message: {
                Text(errorMessage)
            }
        } else {
            ZStack(alignment: .center) {
                content
                    .disabled(ResistanceVM.isAddingDialog)
                    .disabled(ResistanceVM.isErrorDialog)
                if ResistanceVM.isAddingDialog {
                    VStack {
                        Text(Strings.Dialog.titleNewSplit).font(.headline).padding()
                        TextField(Strings.Dialog.textFieldNewName, text: $name).textFieldStyle(.roundedBorder).padding()
                        Divider()
                        HStack{
                            Spacer()
                            Button(role: .cancel) {
                                withAnimation {
                                    ResistanceVM.isAddingDialog.toggle()
                                    name = ""
                                }
                            } label: {
                                Text(Strings.Dialog.cancel)
                            }
                            Spacer()
                            Divider()
                            Spacer()
                            Button() {
                                errorMessage = ResistanceVM.addSplit(name: name)
                                if (errorMessage != Strings.ResistancePage.isAddedSuccessfully)
                                {
                                    ResistanceVM.isErrorDialog.toggle()
                                }
                                name = ""
                                ResistanceVM.isAddingDialog.toggle()
                                
                            } label: {
                                Text(Strings.Dialog.confirm)
                            }
                            Spacer()
                        }
                    }
                    .background(.background)
                    .frame(width: 300, height: 200)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.quaternary, lineWidth: 1)
                    }
                }
                if ResistanceVM.isErrorDialog{
                    VStack {
                        Text(Strings.Dialog.titleError).font(.headline).padding()
                        Text(errorMessage).padding()
                        Divider()
                        Button(role: .cancel) {
                            withAnimation {
                                ResistanceVM.isErrorDialog.toggle()
                            }
                        } label: {
                            Text(Strings.Dialog.confirm)
                        }.padding()
                    }.background(.background)
                        .frame(width: 300, height: 175)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.quaternary, lineWidth: 1)
                        }
                }
            }
        }
    }
}

struct TextFieldAlertExcercise: ViewModifier {
    @ObservedObject var excerciseVM: ExcerciseViewModel
    
    @State var addingName = ""
    @State var errorMessage = ""
    @State var isErrorDialog = false
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.alert(Strings.Dialog.titleNewExcercise, isPresented: $excerciseVM.isAddingDialog) {
                TextField(Strings.Dialog.textFieldNewName, text: $addingName)
                    .textInputAutocapitalization(.never)
                Button(Strings.Dialog.confirm){
                    errorMessage = excerciseVM.addExcercsise(name: addingName)
                    if (errorMessage != Strings.ExcercisePage.isAddedSuccessfully)
                    {
                        isErrorDialog.toggle()
                    }
                    addingName = ""
                }
                Button(Strings.Dialog.cancel, role: .cancel) { addingName = ""}
            }message: {
                Text(Strings.Dialog.messageNewExcerciseEnterName)
            }
            .alert(Strings.Dialog.titleError, isPresented: $isErrorDialog){
                EmptyView()
            }message: {
                Text(errorMessage)
            }
        } else {
            ZStack(alignment: .center) {
                content
                    .disabled(excerciseVM.isAddingDialog)
                    .disabled(isErrorDialog)
                if excerciseVM.isAddingDialog {
                    VStack {
                        Text(Strings.Dialog.titleNewExcercise).font(.headline).padding()
                        TextField(Strings.Dialog.textFieldNewName, text: $addingName).textFieldStyle(.roundedBorder).padding()
                        Divider()
                        HStack{
                            Spacer()
                            Button(role: .cancel) {
                                withAnimation {
                                    excerciseVM.isAddingDialog.toggle()
                                }
                            } label: {
                                Text(Strings.Dialog.cancel)
                            }
                            Spacer()
                            Divider()
                            Spacer()
                            Button() {
                                errorMessage = excerciseVM.addExcercsise(name: addingName)
                                if (errorMessage != Strings.ExcercisePage.isAddedSuccessfully)
                                {
                                    isErrorDialog.toggle()
                                }
                                addingName = ""
                                excerciseVM.isAddingDialog.toggle()
                            } label: {
                                Text(Strings.Dialog.confirm)
                            }
                            Spacer()
                        }
                    }
                    .background(.background)
                    .frame(width: 300, height: 200)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.quaternary, lineWidth: 1)
                    }
                }
                if isErrorDialog{
                    VStack {
                        Text(Strings.Dialog.titleError).font(.headline).padding()
                        Text(errorMessage).padding()
                        Divider()
                        Button(role: .cancel) {
                            withAnimation {
                                isErrorDialog.toggle()
                            }
                        } label: {
                            Text(Strings.Dialog.confirm)
                        }.padding()
                    }.background(.background)
                        .frame(width: 300, height: 175)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.quaternary, lineWidth: 1)
                        }
                }
            }
        }
    }
}

extension View {
    func resistanceTextFieldAlert(
        resistanceVM: ResistanceViewModel
    ) -> some View {
        self.modifier(TextFieldAlertResistance(ResistanceVM: resistanceVM))
    }
    
    func excerciseTextFieldAlert(
        excerciseVM: ExcerciseViewModel
    ) -> some View {
        self.modifier(TextFieldAlertExcercise(excerciseVM: excerciseVM))
    }
}
