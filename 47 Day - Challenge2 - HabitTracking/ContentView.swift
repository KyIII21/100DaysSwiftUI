//
//  ContentView.swift
//  47 Day - Challenge2 - HabitTracking
//
//  Created by Дмитрий on 03.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var listHabbits = Habbits()
    @State private var showingSheetAddH = false
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(self.listHabbits.arrHabbits){item in
                        NavigationLink(destination: HabbitView(habbit: item, habbits: self.listHabbits)){
                            HStack{
                                Text("\(item.printName())")
                                Spacer()
                                Text("\(item.count)")
                            }
                        }
                    }
                    .onDelete(perform: self.listHabbits.deleteHabbit)
                }
                
            }
            .navigationBarTitle("HabbitTracking")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {self.showingSheetAddH = true}){
                Image(systemName: "plus")
            }
                .sheet(isPresented: self.$showingSheetAddH){
                    SheetAddH(listHabbits: self.listHabbits)
                }
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




