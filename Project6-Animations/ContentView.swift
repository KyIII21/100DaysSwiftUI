//
//  ContentView.swift
//  Project6-Animations
//
//  Created by Дмитрий on 21.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .padding(30)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(
            Animation.easeInOut(duration: 1)
                .repeatForever(autoreverses: true)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
