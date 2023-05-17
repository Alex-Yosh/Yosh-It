//
//  ExcerciseListView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-17.
//

import Foundation
import SwiftUI



struct ExcerciseListView: View{
    
    @ObservedObject var excerciseVM: ExcerciseViewModel

    var body: some View{
        List(){
            ForEach(excerciseVM.split.excercises){excercise in
                Listitem(item: excercise)
            }
        }.ignoresSafeArea(.all)
    }
    
}






struct Listitem: View{
    
    var item: Excercise
    
    var body: some View{
        Text(item.name)
    }
    
}
