//
//  ContentView.swift
//  Project7 - IExpense ( @ObservedObject, sheet(), onDelete() )
//
//  Created by Дмитрий on 26.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
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
