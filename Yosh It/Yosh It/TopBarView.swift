//
//  TopBarView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-01-08.
//

import Foundation
import SwiftUI

struct TopBarView: View {
    
    @State var title: String?
    
    var body: some View {
        HStack (alignment: .bottom){
            Text(title!)
            Spacer()
            Image(systemName: "gearshape.fill")
        }.foregroundColor(.white)
            .frame(maxWidth:.infinity)
            .padding()
            .background(CustomColours.MainIndigo)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(title:"Title")
    }
}

