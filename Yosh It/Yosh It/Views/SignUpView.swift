//
//  SignUpView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-09.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    
    @StateObject var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                
                VStack{
                    TextField("Username", text: $signUpViewModel.username)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(CustomColours.MainIndigo, style: StrokeStyle(lineWidth: 3.0)))
                    ForEach(0...C.SignUpPage.numUsernameRequirements-1, id: \.self){i in
                        Text(signUpViewModel.usernameMessages[i])
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity ,alignment: .leading)
                    }
                }.padding()
                
                VStack{
                    VStack{
                        SecureField("Password", text: $signUpViewModel.password)
                        Divider()
                            .overlay(CustomColours.MainIndigo)
                        SecureField("Password Again", text: $signUpViewModel.passwordAgain)
                    }
                    .autocapitalization(.none)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(CustomColours.MainIndigo, style: StrokeStyle(lineWidth: 3.0)))
                    ForEach(0...C.SignUpPage.numPasswordRequirements-1, id: \.self){i in
                        Text(signUpViewModel.passwordMessages[i])
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity ,alignment: .leading)
                    }
                }.padding()
                
                
                NavigationLink(destination: ResistanceView().navigationBarTitle("") .navigationBarHidden(true), label:{
                    Text("Sign up")
                }).disabled(!self.signUpViewModel.isValid)
            }
        }.navigationViewStyle(.stack)
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
