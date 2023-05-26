//
//  ResistancePreviousView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-27.
//

import Foundation
import SwiftUI

struct ResistancePreviousView: View{
    
    @EnvironmentObject var user: User
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            Text(Strings.ResistancePage.previous).foregroundColor(CustomColours.MainIndigo)
                .font(.system(size: 30, weight: .heavy, design: .default)).padding(.top)
            
            Divider().background(CustomColours.MainIndigo).padding([.trailing, .vertical])
            VStack(alignment: .leading){
                ForEach (user.previousSplits){ split in
                    HStack{
                        Text(split.name)
                        Spacer()
                        Text(split.getLastDateCompleted())
                    }.font(.system(size: 12))
                }
            }
        }.padding(.trailing, 20)
        
        
    }
}
