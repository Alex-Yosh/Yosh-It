//
//  SignUpViewModel.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-09.
//

import Foundation

class SignUpViewModel: ObservableObject{
    
    //User Info
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    
    
    //ErrorMessage
    @Published var usernameErrorMessage = ""
    @Published var passwordErrorMessage = ""

    //Navigation
    @Published var showNextScreen = false
    @Published var isValid = false
    
    init(){
        
    }
}
