//
//  ExcerciseView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-16.
//

import Foundation
import SwiftUI

struct ExcerciseView: View {
    
    @ObservedObject var excerciseVM: ExcerciseViewModel
    
    var body: some View {
        VStack(spacing:0){
            TopBarView(title: excerciseVM.split.name)
            
            ExcerciseListView(excerciseVM: excerciseVM)
            
            Button(action: {
                let testExcercise = Excercise(Name: "Test")
                excerciseVM.addExcercsise(excercise: testExcercise)
            }, label: {
                Text("Add Excercise").foregroundColor(CustomColours.MainIndigo)
            }).padding(.bottom)
        }.background(CustomColours.Background).edgesIgnoringSafeArea(.bottom)
    }
}


struct ExcerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExcerciseView(excerciseVM: ExcerciseViewModel(Split: Split(name: "test")))
    }
}
