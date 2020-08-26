//
//  SettingView.swift
//  Project17 - Flashzilla
//
//  Created by Дмитрий on 26.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var returnCard: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Return card", isOn: $returnCard)
            }
            .navigationBarTitle("Setting")
            .navigationBarItems(trailing: Button("Done", action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
