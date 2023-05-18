//
//  Constants.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-11.
//

import Foundation
import SwiftUI

struct C{
    
    struct SignUpPage{
        static let numUsernameRequirements = 2
        static let numPasswordRequirements = 3
        static let usernameRequiredLength = 6
        static let usernameMaxLength = 10
        static let passwordRequiredLength = 6
        static let passwordMaxLength = 10
    }
    
    struct ExcercisePopup{
        static let numberOfRows = 8
        
        enum RowState{
            case clear, correct, incorrect
        }
    }
    
}
