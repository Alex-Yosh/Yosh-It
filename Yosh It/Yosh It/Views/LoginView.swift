//
//  LoginView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-11.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                
                    TextField("Username", text: $loginViewModel.username)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(CustomColours.MainIndigo, style: StrokeStyle(lineWidth: 3.0)))
                
                
                    VStack{
                        SecureField("Password", text: $loginViewModel.password)
                    }
                    .autocapitalization(.none)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(CustomColours.MainIndigo, style: StrokeStyle(lineWidth: 3.0)))
                    
                    }
                
                
                NavigationLink(destination: ResistanceView().navigationBarTitle("") .navigationBarHidden(true), label:{
                    Text("Sign up")
                }).disabled(!self.loginViewModel.isValid)
        }.padding()
            .navigationViewStyle(.stack)
        }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
