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
        ZStack{
            
            List(){
                ForEach(excerciseVM.tempSplit.excercises){excercise in
                    Button(action: {
                        excerciseVM.createPopup(ExcerciseName: excercise.name)
                    }, label: {
                        Listitem(item: excercise)
                    }).disabled(excercise.isComplete)
                }
            }.ignoresSafeArea(.all).background(CustomColours.Background)
        }
    }
    
}


struct Listitem: View{
    
    var item: Excercise
    
    var body: some View{
        Text(item.name)
    }
    
}
