//
//  ContentView.swift
//  Project15 - Accessibility
//
//  Created by Дмитрий on 29.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
