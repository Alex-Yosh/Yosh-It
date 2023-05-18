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
    @Binding var isAddingWorkout: Bool
    @State var test = ""
    
    var body: some View{
        ZStack{
            
            List(){
                ForEach(excerciseVM.split.excercises){excercise in
                    Button(action: {
                        isAddingWorkout.toggle()
                    }, label: {
                        Listitem(item: excercise)
                    })
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
