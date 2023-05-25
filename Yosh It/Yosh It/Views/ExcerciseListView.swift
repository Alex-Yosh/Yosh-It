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
                        .listRowBackground(Color.white)
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
        HStack{
            Text(item.name).foregroundColor(item.isComplete ? .gray : .black)
            Spacer()
            if (item.isComplete){
                Image(systemName:"checkmark")
                    .foregroundColor(.green)
            }
        }
    }
    
}
