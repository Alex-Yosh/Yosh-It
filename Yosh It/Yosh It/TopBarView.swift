//
//  TopBarView.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-01-08.
//

import Foundation
import SwiftUI

struct TopBarView: View {
    var body: some View {
        HStack (alignment: .bottom){
            Text("Resistance").foregroundColor(Color.white)
        }.frame(maxWidth: .infinity).edgesIgnoringSafeArea(.all).background(CustomColours.MainIndigo)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
