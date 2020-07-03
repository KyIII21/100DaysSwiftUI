//
//  SheetAddH.swift
//  47 Day - Challenge2 - HabitTracking
//
//  Created by Дмитрий on 03.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct SheetAddH: View {
    @State private var name = ""
    @State private var description = ""
    @ObservedObject var listHabbits: Habbits
    @Environment(\.presentationMode) var prMode
    @State var showingRequired = false
    
    func save(){
        //self.listHabbits.arrHabbits.append(Habbit(name: self.name, description: self.description))
        if self.name != "" {
            self.listHabbits.add(habbit: Habbit(name: self.name, description: self.description))
            self.prMode.wrappedValue.dismiss()
        }else{
            self.showingRequired = true
        }
        
        
    }
    
    var body: some View {
        NavigationView {
            VStack{
                Form{
                    Section(header: Text("Habbit name").foregroundColor(self.showingRequired ? Color.red : nil)){
                        TextField("Ex. chess..", text: self.$name)
                            
                            
                    }
                    Section(header: Text("Description")){
                        TextField("What will You doing?", text: self.$description)
                    }
                }
                
            }
                .navigationBarTitle("Add Habbit")
                .navigationBarItems(trailing: Button(action: self.save){
                    Text("Save")
            })
        }
    }
}

struct SheetAddH_Previews: PreviewProvider {
    static var previews: some View {
        SheetAddH(listHabbits: Habbits())
    }
}
