//
//  User.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation
import Combine


struct User{
    var splits: [Split]
    var lastSplit: Split
    private var username: String
    private var password: String

    
    init(Username: String, Password: String){
        username = Username
        password = Password
        lastSplit = Split(name: "")
        splits = []
    }
    
    
}
