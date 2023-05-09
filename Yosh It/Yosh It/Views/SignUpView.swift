//
//  SignUpView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-09.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    
    @ObservedObject private var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Username", text: $signUpViewModel.username)
                    .autocapitalization(.none)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(CustomColours.MainIndigo, style: StrokeStyle(lineWidth: 3.0)))
                    .padding()
                Text(signUpViewModel.usernameErrorMessage)
                    .foregroundColor(.red)
                
                VStack{
                    TextField("Password", text: $signUpViewModel.password)
                    Divider()
                        .overlay(CustomColours.MainIndigo)
                    TextField("Password Again", text: $signUpViewModel.passwordAgain)
                }
                .autocapitalization(.none)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(CustomColours.MainIndigo, style: StrokeStyle(lineWidth: 3.0)))
                .padding()
                Text(signUpViewModel.passwordErrorMessage)
                    .foregroundColor(.red)
                
                Button(action: {signUpViewModel.showNextScreen = true}) {
                    Text("Sign up")
                }.disabled(!self.signUpViewModel.isValid)
                
                
                //navigation
                NavigationLink(destination: ResistanceView().navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true), isActive: $signUpViewModel.showNextScreen, label: {EmptyView()})
                
            }
        }
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
