//
//  TabsView.swift
//  Project16 - HotProspect
//
//  Created by Дмитрий on 18.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack{
                Text("Tab 1")
                Text("Tab 11")
            }
            .onTapGesture {
                self.selectedTab = 1
            }
            .tabItem {
                Image(systemName: "star")
                Text("One")
            }
            .tag(0)

            Text("Tab 2")
                .onTapGesture {
                    self.selectedTab = 0
                }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag(1)
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
