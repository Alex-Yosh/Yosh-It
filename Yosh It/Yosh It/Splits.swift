//
//  Splits.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-12.
//

import Foundation


struct Split: Identifiable{
    var id = UUID()
    private var name: String
    
    init(name: String) {
        self.name = name
    }
}
