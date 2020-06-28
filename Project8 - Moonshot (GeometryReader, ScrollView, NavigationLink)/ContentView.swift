//
//  ContentView.swift
//  Project8 - Moonshot (GeometryReader, ScrollView, NavigationLink)
//
//  Created by Дмитрий on 28.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("Kush")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
