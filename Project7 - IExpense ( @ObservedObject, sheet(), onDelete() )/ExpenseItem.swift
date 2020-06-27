//
//  ExpenseItem.swift
//  Project7 - IExpense ( @ObservedObject, sheet(), onDelete() )
//
//  Created by Дмитрий on 27.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init(){
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decodeItem = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decodeItem
                return
            }
        }
        self.items = []
    }
}

