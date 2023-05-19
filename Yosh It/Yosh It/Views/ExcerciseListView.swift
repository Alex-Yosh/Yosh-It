//
//  ExcerciseListView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-17.
//

import Foundation
import SwiftUI


struct ExcerciseListView: View{
    
    var SplitName: String
    @ObservedObject var excerciseVM: ExcerciseViewModel
    @EnvironmentObject var user: User
    
    var body: some View{
        ZStack{
            
            List(){
                ForEach(user.splits[user.getSplitIndex(name: SplitName)].excercises){excercise in
                    Button(action: {
                        excerciseVM.excercisename = excercise.name
                        excerciseVM.isAddingWorkout.toggle()
                    }, label: {
                        Listitem(item: excercise)
                    })
                }
            }.ignoresSafeArea(.all).background(CustomColours.Background)
        }.onAppear(perform: {
            excerciseVM.splitname = SplitName
        })
    }
    
}


struct Listitem: View{
    
    var item: Excercise
    
    var body: some View{
        Text(item.name)
    }
    
}
