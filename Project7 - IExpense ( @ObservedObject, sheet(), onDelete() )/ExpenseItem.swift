//
//  ExpenseItem.swift
//  Project7 - IExpense ( @ObservedObject, sheet(), onDelete() )
//
//  Created by Дмитрий on 27.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

