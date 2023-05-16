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
    
    var gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        LazyVGrid(columns: gridItems, spacing: 5){
            ForEach(ResistnaceVM.splits){ split in
                CellContentView(selectedSplit: split)
            }
            AddCellView(ResistnaceVM: ResistnaceVM)
            
        }
    }
}

struct CellContentView: View{
    var selectedSplit: Split
    
    var body: some View{
        NavigationLink(destination:  EmptyView()){
            ZStack{
                Rectangle().frame(minWidth: 100, maxWidth: .infinity, minHeight: 150).foregroundColor(.white).border(.black, width: 5).cornerRadius(10)
                Text(selectedSplit.name).foregroundColor(.black)
            }
        }.padding(10)
    }
}


struct AddCellView: View{
    @State private var isAdding = false
    @State private var isError = false
    @State private var name = ""
    @ObservedObject var ResistnaceVM : ResistanceViewModel
    @State private var errorMessage = ""
    
    
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
        .alert(Strings.Dialog.titleNewSplit, isPresented: $isAdding) {
            TextField(Strings.Dialog.textFieldNewSplit, text: $name)
                .textInputAutocapitalization(.never)
            Button(Strings.Dialog.confirm){
                errorMessage = ResistnaceVM.addSplit(name: name)
                if (errorMessage != Strings.ResistancePage.isAddedSuccessfully)
                {
                    isError.toggle()
                }
                name = ""
            }
            Button(Strings.Dialog.cancel, role: .cancel) { name = ""}
        }message: {
            Text(Strings.Dialog.messageNewSplitEnterName)
        }
        .alert(Strings.Dialog.titleError, isPresented: $isError){
            EmptyView()
        }message: {
            Text(errorMessage)
        }
        
    }
    
}

