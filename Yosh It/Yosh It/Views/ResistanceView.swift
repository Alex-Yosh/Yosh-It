//
//  ResistanceView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-01-08.
//

import Foundation
import SwiftUI

struct ResistanceView: View {
    
    @StateObject var user = User.userObj
    @StateObject var ResistanaceVM  = ResistanceViewModel()
    
    var body: some View {
        NavigationView(){
            VStack(spacing: 0){
                TopBarView(title: Strings.ResistancePage.pageName)
                
                ScrollView(){
                    if(user.previousSplits.count > 0){
                        HStack(alignment: .top, spacing: 0){
                            ResistanceLastWorkoutView()
                            ResistancePreviousView()
                        }
                    }
                    
                    ResistanceGridView(ResistnaceVM: ResistanaceVM ).navigationBarHidden(true)
                }
            }.background(CustomColours.Background).edgesIgnoringSafeArea(.bottom)
            
        }.onAppear(perform: {
            ResistanaceVM.user = user
        }).environmentObject(user)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ResistanceView_Previews: PreviewProvider {
    static var previews: some View {
        ResistanceView()
    }
}
