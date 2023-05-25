//
//  ResistanceGrid.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-12.
//

import Foundation
import SwiftUI


struct ResistanceGridView: View{
    @ObservedObject var ResistnaceVM : ResistanceViewModel
    @EnvironmentObject var user: User
    
    
    var gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        LazyVGrid(columns: gridItems, spacing: 5){
            ForEach(user.splits){ split in
                CellContentView(selectedSplit: split)
            }
            AddCellView(isAdding: $ResistnaceVM.isAddingDialog)
            
        }.resistanceTextFieldAlert(resistanceVM: ResistnaceVM)
    }
}

struct ResistanceGridView_Previews: PreviewProvider {
  static var previews: some View {
      ResistanceGridView(ResistnaceVM: ResistanceViewModel()).environmentObject(User.userObj)
  }
}

struct CellContentView: View{
    var selectedSplit: Split
    
    var body: some View{
        NavigationLink(destination:  ExcerciseView(SplitName: selectedSplit.name)){
            ZStack{
                Rectangle().frame(minWidth: 100, maxWidth: .infinity, minHeight: 150).foregroundColor(.white).border(.black, width: 5).cornerRadius(10)
                Text(selectedSplit.name).foregroundColor(.black)
            }
        }.padding(10)
    }
}


struct AddCellView: View{
    @Binding var isAdding: Bool
    
    
    var body: some View{
        
        Button(action: {
            isAdding.toggle()
        }) {
            ZStack{
                Rectangle()
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 150)
                    .foregroundColor(.clear).border(.black, width: 5)
                    .cornerRadius(10)
                
                ZStack{
                    Circle().frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
            }.padding(10)
        }
    }
    
}

