//
//  SettingsView.swift
//  Day95 - Challenge Bones
//
//  Created by Дмитрий on 13.09.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Binding var countEdge: Int
    @Environment(\.presentationMode) var presentationMode
    let edges = [4,6,8,20,100]
    var body: some View {
        NavigationView{
            Picker("Select a count edge", selection: $countEdge){
                ForEach(0..<edges.count){
                    Text(String(self.edges[$0]))
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            .navigationBarItems(trailing: Button(action: {self.presentationMode.wrappedValue.dismiss()}){Text("Close")})
        }

    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
