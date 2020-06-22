//
//  ContentView.swift
//  Project6-Animations
//
//  Created by Дмитрий on 21.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation{
                    self.isShowingRed.toggle()
                }
                
            }
            if self.isShowingRed {
                LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: self.isShowingRed ? .bottom : .top, endPoint: self.isShowingRed ? .trailing : .trailing)
                    .frame(width: 100, height: 300)
                    //.opacity(self.isShowingRed ? 1 : 0)
                    .transition(.pivot)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
