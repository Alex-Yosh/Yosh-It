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
                if(excerciseVM.tempSplit.excercises.isEmpty){
                    Spacer().listRowBackground(Color.clear)
                }
            }
            .clearListBackground()
        }
        .background(CustomColours.Background.ignoresSafeArea(.all))
    }
    
}


struct Listitem: View{
    
    var item: Excercise
    
    var body: some View{
        Text(item.name)
    }
    
}
