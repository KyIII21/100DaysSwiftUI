//
//  ContentView.swift
//  Day95 - Challenge Bones
//
//  Created by Дмитрий on 29.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "dice"
    @State private var showing = "dice"
    
    var diceObj = DiceArray()
       
       var body: some View {
           TabView(selection: $selectedTab) {
               DiceView()
                   .tabItem {
                       Image(systemName: "tornado")
                       Text("Dice")
                   }
                   .tag("dice")

               ResultsView()
                   .tabItem {
                       Image(systemName: "list.number")
                       Text("Results")
                   }
                   .tag("results")
           }.environmentObject(diceObj)
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
