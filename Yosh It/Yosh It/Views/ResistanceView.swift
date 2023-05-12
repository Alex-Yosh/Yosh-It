//
//  ResistanceView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-01-08.
//

import Foundation
import SwiftUI

struct ResistanceView: View {
    
    @StateObject var ResistnaceViewModel = ResistanceViewModel()
    
    var body: some View {
        NavigationView(){
            VStack{
                TopBarView(title:"Resistance")
                Spacer()
                
                ScrollView{
                    ResistanceGridView(splits: $ResistnaceViewModel.splits)
                }
            }.background(CustomColours.Background).edgesIgnoringSafeArea(.bottom)
            
            
        }
    }
}

struct ResistanceView_Previews: PreviewProvider {
    static var previews: some View {
        ResistanceView()
    }
}
