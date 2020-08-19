//
//  ContextMenusView.swift
//  Project16 - HotProspect
//
//  Created by Дмитрий on 19.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContextMenusView: View {
    @State private var backgroundColor = Color.red

       var body: some View {
           VStack {
               Text("Hello, World!")
                   .padding()
                   .background(backgroundColor)

               Text("Change Color")
                   .padding()
                   .contextMenu {
                       Button(action: {
                           self.backgroundColor = .red
                       }) {
                           Text("Red")
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.red)
                       }

                       Button(action: {
                           self.backgroundColor = .green
                       }) {
                           Text("Green")
                       }

                       Button(action: {
                           self.backgroundColor = .blue
                       }) {
                           Text("Blue")
                       }
                   }
           }
       }
}

struct ContextMenusView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenusView()
    }
}
