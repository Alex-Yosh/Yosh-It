//
//  ResistanceView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-01-08.
//

import Foundation
import SwiftUI

struct ResistanceView: View {
    
    @StateObject var ResistnaceVM  = ResistanceViewModel()
    
    var body: some View {
        NavigationView(){
            VStack(spacing: 0){
                TopBarView(title: Strings.ResistancePage.pageName)
                
                ScrollView(){
                    ResistanceGridView(ResistnaceVM: ResistnaceVM )
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
