//
//  ResistanceViewModel.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-09.
//

import Foundation
import Combine


class ResistanceViewModel: ObservableObject{
    
    
    @Published var user: User!
    @Published var isAddingDialog = false
    @Published var isErrorDialog = false
    
    init(){
    }
    
    
    
    
    //if error, does not append. returns status as a string
    func addSplit(name: String) -> String {
        
        if (user.splits.contains(where: { split in
            split.name == name
        })){
            return Strings.ResistancePage.isAlreadyError
        }
        
        if (name == ""){
            return Strings.ResistancePage.isEmptyError
        }
        
        
        user.splits.append(Split(name: name))
        return Strings.ResistancePage.isAddedSuccessfully
        
    }
}
