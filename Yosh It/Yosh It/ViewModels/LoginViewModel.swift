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
    
    init(){
        
        
    }
    
    
}
