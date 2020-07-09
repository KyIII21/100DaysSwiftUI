//
//  ContentView.swift
//  Project12 - CoreData
//
//  Created by Дмитрий on 09.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI



struct ContentView: View {

    var body: some View {
        ShipView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
