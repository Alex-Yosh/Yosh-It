//
//  Excercise.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation

struct Excercise: Identifiable{
    internal var id = UUID()
    var name: String
    private var lastDate: String?
    private var splits: [Workout]
    private var prOne: Double?
    private var prThree: Double?
    private var prSix: Double?
    
    
    init(Name: String){
        name = Name
        splits = [Workout]()
    }
    
}
