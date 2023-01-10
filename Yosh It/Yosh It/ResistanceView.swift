//
//  ResistanceView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-01-08.
//

import Foundation
import SwiftUI

struct ResistanceView: View {
    var body: some View {
        VStack{
            TopBarView(title:"Resistance")
            Spacer()
            Text("dsedsd")
        }.background(CustomColours.Background).edgesIgnoringSafeArea(.bottom)
    }
}

struct ResistanceView_Previews: PreviewProvider {
    static var previews: some View {
        ResistanceView()
    }
}
