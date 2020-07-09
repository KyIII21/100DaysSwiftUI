//
//  ShipView.swift
//  Project12 - CoreData
//
//  Created by Дмитрий on 09.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ShipView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var ships: FetchedResults<Ship>
    
    //NSPredicate(format: "name < %@", "F")
    //NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    //NSPredicate(format: "name BEGINSWITH %@", "E")
    //NSPredicate(format: "name CONTAINS[c] %@", "E")
    //NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")
    //NSPredicate(format: "name CONTAINS[c] %@ AND name < %@", "o", "G")
    //NSCompoundPredicate - для нескольких предикатов

   var body: some View {
       VStack {
           List(ships, id: \.self) { ship in
               Text(ship.name ?? "Unknown name")
           }

           Button("Add Examples") {
               let ship1 = Ship(context: self.moc)
               ship1.name = "Enterprise"
               ship1.universe = "Star Trek"

               let ship2 = Ship(context: self.moc)
               ship2.name = "Defiant"
               ship2.universe = "Star Trek"

               let ship3 = Ship(context: self.moc)
               ship3.name = "Millennium Falcon"
               ship3.universe = "Star Wars"

               let ship4 = Ship(context: self.moc)
               ship4.name = "Executor"
               ship4.universe = "Star Wars"

               try? self.moc.save()
           }
       }
   }
}

struct ShipView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ShipView().environment(\.managedObjectContext, context)
    }
}

