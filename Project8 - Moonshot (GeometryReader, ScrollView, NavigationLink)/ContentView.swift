//
//  ContentView.swift
//  Project8 - Moonshot (GeometryReader, ScrollView, NavigationLink)
//
//  Created by Дмитрий on 28.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct CustomText: View {
    var text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        HStack{
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    ForEach(0..<100) {
                        //Создаются сразу
                        CustomText("Item \($0)")
                            .font(.title)
                    }
                }
            }
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    ForEach(0..<100) {
                        //Создаются по мере прокручивания
                        Text("Item \($0)")
                            .font(.title)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
