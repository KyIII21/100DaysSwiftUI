//
//  FilteredList.swift
//  Project12 - CoreData
//
//  Created by Дмитрий on 09.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
    
    init(sortDescr: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content){
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescr, predicate: nil)
        //NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue)
        self.content = content
    }
    
    init(filterKey: String, filterValue: String, sortDescr: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content){
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescr, predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
    
    init(strPredicate: SingView.Predicates, filterKey: String, filterValue: String, sortDescr: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content){
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescr, predicate: NSPredicate(format: "%K " + strPredicate.rawValue + " %@", filterKey, filterValue))
        self.content = content
    }
    

}


