//
//  ResistanceLastWorkoutView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-26.
//

import Foundation
import SwiftUI


struct ResistanceLastWorkoutView: View{
    
    @EnvironmentObject var user: User
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            Text(Strings.ResistancePage.lastWorkout).foregroundColor(CustomColours.MainIndigo)
                .font(.system(size: 30, weight: .heavy, design: .default)).padding(.top)
            
            Divider().background(CustomColours.MainIndigo).padding([.trailing, .vertical])
            VStack(alignment: .leading){
                Text(Strings.ResistancePage.lastWorkoutSplitName + user.previousSplits[0].name)
                Text(Strings.ResistancePage.lastWorkoutDate + user.previousSplits[0].getLastDateCompleted())
                Text(Strings.ResistancePage.lastWorkoutTotalSets + String(user.previousSplits[0].lastTotalSets))
                Text(Strings.ResistancePage.lastWorkoutTotalReps + String(user.previousSplits[0].lastTotalReps))
                Text(Strings.ResistancePage.lastWorkoutTotalWeight + String(user.previousSplits[0].lastTotalWeight) + " lb")
            }.font(.system(size: 12))
        }.padding(.leading, 20)
        
        
    }
}
//
//struct ResistanceLastWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResistanceLastWorkoutView(ResistnaceVM: ResistanceViewModel()).environmentObject(User.userObj)
//    }
//}
