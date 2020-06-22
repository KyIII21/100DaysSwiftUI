//
//  ContentView.swift
//  Project6-Animations
//
//  Created by Дмитрий on 21.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation{
                    self.isShowingRed.toggle()
                }
                
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    //.transition(self.isShowingRed ? .opacity : .identity)
                    .transition(.asymmetric(insertion: .opacity, removal: .scale))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
