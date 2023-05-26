//
//  User.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation
import Combine


class User: ObservableObject{
    //singleton
    static let userObj = User()
    
    // create a private initializer
    private init() {
        splits = []
        previousSplits=[]
    }
    
    @Published var splits: [Split]
    @Published var previousSplits: [Split]
    private var username: String?
    private var password: String?
    
    
    func getSplitIndex(name: String) -> Int{
        for i in (0..<splits.count){
            if (splits[i].name == name){
                return i
            }
        }
        return -1
    }
    
}
