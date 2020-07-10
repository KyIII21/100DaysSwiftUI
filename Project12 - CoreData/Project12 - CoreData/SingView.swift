//
//  SingView.swift
//  Project12 - CoreData
//
//  Created by Дмитрий on 09.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct SingView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var sortDescr: NSSortDescriptor = NSSortDescriptor(keyPath: \Singer.firstName, ascending: true)
    
    enum Predicates: String, CaseIterable, Hashable, Identifiable{
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
        case beginsWithReg = "BEGINSWITH[c]"
        case containsReg = "CONTAINS[c]"
        case equal = "=="
        case greater = ">"
        case smaller = "<"
        
        var id: Predicates {self}
    }
    @State private var howSortPredicate: Predicates = .beginsWith
    
    var body: some View {
        VStack {
            /*FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }*/
//            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, sortDescr: [self.sortDescr]) { (singer: Singer) in
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }
            FilteredList(strPredicate: self.howSortPredicate, filterKey: "lastName", filterValue: lastNameFilter, sortDescr: [self.sortDescr]) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                let alen = Singer(context: self.moc)
                alen.firstName = "Alen"
                alen.lastName = "Adkins"

                if self.moc.hasChanges{
                    try? self.moc.save()
                }
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
            Picker(selection: self.$howSortPredicate, label: Text("")){
                ForEach(Predicates.allCases){ myCase in
                    Text("\(myCase.rawValue.lowercased())")
                        .font(.caption)
                }
            }
                .pickerStyle(SegmentedPickerStyle())
            
            Button("Change Sort") {
                if self.sortDescr.keyPath == \Singer.firstName{
                    self.sortDescr = NSSortDescriptor(keyPath:  \Singer.lastName, ascending: self.sortDescr.ascending)
                }else{
                    self.sortDescr = NSSortDescriptor(keyPath:  \Singer.firstName , ascending: self.sortDescr.ascending)
                }
            }
            Button("Change Sort Asc") {
                if self.sortDescr.ascending{
                    self.sortDescr = NSSortDescriptor(keyPath: self.sortDescr.keyPath == \Singer.firstName ? \Singer.firstName : \Singer.lastName, ascending: false)
                }else{
                    self.sortDescr = NSSortDescriptor(keyPath: self.sortDescr.keyPath == \Singer.firstName ? \Singer.firstName : \Singer.lastName, ascending: true)
                }
                
            }
        }
    }
}

struct SingView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return SingView().environment(\.managedObjectContext, context)
    }
}
