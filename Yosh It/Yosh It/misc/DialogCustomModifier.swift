//
//  DialogCustomModifier.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-24.
//

import Foundation
import SwiftUI

struct TextFieldAlert: ViewModifier {
    @ObservedObject var ResistanceVM: ResistanceViewModel
    @Binding var isAdding: Bool
    @State var isError: Bool = false
    @Binding var name: String
    @State var errorMessage: String = ""
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.alert(Strings.Dialog.titleNewSplit, isPresented: $isAdding) {
                TextField(Strings.Dialog.textFieldNewSplit, text: $name)
                    .textInputAutocapitalization(.never)
                Button(Strings.Dialog.confirm){
                    errorMessage = ResistanceVM.addSplit(name: name)
                    if (errorMessage != Strings.ResistancePage.isAddedSuccessfully)
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
        } else {
            ZStack(alignment: .center) {
                content
                    .disabled(isAdding)
                if isAdding {
                    VStack {
                        Text(Strings.Dialog.titleNewSplit).font(.headline).padding()
                        TextField(Strings.Dialog.textFieldNewSplit, text: $name).textFieldStyle(.roundedBorder).padding()
                        Divider()
                        HStack{
                            Spacer()
                            Button(role: .cancel) {
                                withAnimation {
                                    isAdding.toggle()
                                }
                            } label: {
                                Text("Cancel")
                            }
                            Spacer()
                            Divider()
                            Spacer()
                            Button() {
                                errorMessage = ResistanceVM.addSplit(name: name)
                                if (errorMessage != Strings.ResistancePage.isAddedSuccessfully)
                                {
                                    isError.toggle()
                                }
                                name = ""
                                
                            } label: {
                                Text("Done")
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
            }
        }
    }
}

extension View {
    func resistanceTextFieldAlert(
        resistanceVM: ResistanceViewModel,
        isAdding: Binding<Bool>,
        name: Binding<String>
    ) -> some View {
        self.modifier(TextFieldAlert(ResistanceVM: resistanceVM, isAdding: isAdding, name: name))
    }
}
