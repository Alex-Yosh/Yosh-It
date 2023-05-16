//
//  LoginViewModel.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-11.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject{
    
    //User Info
    @Published var username = ""
    @Published var password = ""
    
    @Published var isValid = false
    
    //publisher to allow sign in button to be enabled
//    private var isAbletoSignInPublisher: AnyPublisher<Bool, Never>{
//
//    }
    
    
    //func once sign in button is clicked, if credentials are correct, log user in
//    func isCorrectCredentials(Username: String, Password: String){
//
//    }
  
    //log user in
//    func LogUserIn(){
//
//    }
    
    
    init(){
        
        
    }
    
    
}
