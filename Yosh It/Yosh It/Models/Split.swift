//
//  Split.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-12.
//

import Foundation
import Combine


struct Split: Identifiable{
    internal var id = UUID()
    var name: String
    var excercises: [Excercise]
    
    
    init(name: String) {
        self.name = name
        excercises = []
    }
    
    
}
