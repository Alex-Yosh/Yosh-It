//
//  ResistanceViewModel.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-09.
//

import Foundation
import Combine


class ResistanceViewModel: ObservableObject{
    
    private var user: User?
    
    @Published var splits = [Split]()
    
    
    //if error, does not append. returns status as a string
    func addSplit(name: String) -> String {
        
        if (splits.contains(where: { split in
            split.name == name
        })){
            return Strings.ResistancePage.isAlreadyError
        }
        
        if (name == ""){
            return Strings.ResistancePage.isEmptyError
        }
        
        
        splits.append(Split(name: name))
        return Strings.ResistancePage.isAddedSuccessfully
        
    }
}
