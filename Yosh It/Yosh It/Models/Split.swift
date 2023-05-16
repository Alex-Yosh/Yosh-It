//
//  Split.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-12.
//

import Foundation


struct Split: Identifiable, Equatable{
    var id = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
