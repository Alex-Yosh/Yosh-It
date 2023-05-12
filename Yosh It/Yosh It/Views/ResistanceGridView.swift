//
//  ResistanceGrid.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-12.
//

import Foundation
import SwiftUI


struct ResistanceGridView: View{
    @Binding var splits: [Split]
    
    var gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        LazyVGrid(columns: gridItems, spacing: 5){
            ForEach(splits){ split in
                CellContentView(selectedSplit: split)
            }
            AddCellView(splits: $splits)
            
        }
    }
}

struct CellContentView: View{
    var selectedSplit: Split
    
    var body: some View{
        NavigationLink(destination:  EmptyView()){
            ZStack{
                Rectangle().frame(minWidth: 100, maxWidth: .infinity, minHeight: 150).foregroundColor(.red).border(.black, width: 5).cornerRadius(10)
            }
        }.padding(10)
    }
}


struct AddCellView: View{
    @Binding var splits: [Split]
    @State private var isAdding = false
    @State private var name = ""
    
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
        .alert("New Split", isPresented: $isAdding) {
            TextField("Name", text: $name)
                .textInputAutocapitalization(.never)
            Button("OK"){
                addSplit()
            }
            Button("Cancel", role: .cancel) { name = ""}
        }message: {
            Text("Please enter the name of your split")
        }
        
    }
    
    func addSplit() {
        splits.append(Split(name: name))
        name = ""
    }
}

