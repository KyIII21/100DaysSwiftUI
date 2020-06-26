//
//  ContentView.swift
//  Project7 - IExpense ( @ObservedObject, sheet(), onDelete() )
//
//  Created by Дмитрий on 26.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
        Button("Tap count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
