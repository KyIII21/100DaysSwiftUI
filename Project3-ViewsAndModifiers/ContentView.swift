//
//  ContentView.swift
//  Project3-ViewsAndModifiers
//
//  Created by Дмитрий on 18.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct BlueTitle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
    }
}
extension View{
    func blueTitleStyle() -> some View{
        self.modifier(BlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("123")
            .blueTitleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
