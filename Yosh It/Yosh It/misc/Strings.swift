//
//  Strings.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-15.
//

import Foundation

struct Strings{
    
    struct Dialog {
        static let confirm = "Confirm"
        static let ok = "Ok"
        static let cancel = "Cancel"
        static let titleError = "Error"
        static let messageNewSplitEnterName = "Please enter the name of your split"
        static let messageNewExcerciseEnterName = "Please enter the name of your excercise"
        static let titleNewSplit = "New Split"
        static let titleNewExcercise = "New Excercise"
        static let textFieldNewName = "Name"
        
    }
    
    struct ResistancePage{
        static let pageName = "Resistance"
        
        static let isAddedSuccessfully = "Added Succesfully"
        static let isEmptyError = "Name was left empty"
        static let isAlreadyError = "Name is already used"
        
    }
    
    struct ExcercisePage{
        static let isAddedSuccessfully = "Added Succesfully"
        static let isEmptyError = "Name was left empty"
        static let isAlreadyError = "Name is already used"
        
    }
    
    struct SignUpPage {
        static let isNotLongEnoughPassword = "- Password must be \(C.SignUpPage.passwordRequiredLength) characters long"
        static let isTooLongPassword = "- Password must be less then \(C.SignUpPage.passwordMaxLength) characters"
        static let isNotEqualPassword = "- Passwords must be equal"
        
        
        static let isNotLongEnoughUsername = "- Username must be \(C.SignUpPage.usernameRequiredLength) characters long"
        static let isTooLongUsername = "- Username must be less then \(C.SignUpPage.usernameMaxLength) characters"
        static let isNotEqualUsername = "- Username must be equal"
    }
    
}
