//
//  Habbits.swift
//  47 Day - Challenge2 - HabitTracking
//
//  Created by Дмитрий on 03.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct Habbit: Identifiable, Codable {
    let id = UUID()
    private let name: String
    private let description: String
    var count: Int32 = 0
    
    func printName() ->String {
        return self.name
    }
    func printDescription() ->String {
        return self.description
    }
    mutating func countPlus(){
        self.count += 1
    }
    mutating func countMinus(){
        if self.count > 0{
            self.count -= 1
        }
    }
    
    init(name: String, description: String){
        self.name = name
        self.description = description
    }
}

class Habbits: ObservableObject {
    @Published var arrHabbits: [Habbit]{
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(arrHabbits) {
                UserDefaults.standard.set(encoded, forKey: "Habbits")
            }
        }
    }
    
    init(){
        if let items = UserDefaults.standard.data(forKey: "Habbits"){
            let decoder = JSONDecoder()
            if let decodeItem = try? decoder.decode([Habbit].self, from: items){
                self.arrHabbits = decodeItem
                return
            }
        }
        self.arrHabbits = []
    }
    
    init(habbits: Habbit...) {
        self.arrHabbits = [] // добавить код
        for habbit in habbits{
            self.arrHabbits.append(habbit)
        }
    }
    
    func add(habbit: Habbit){
        self.arrHabbits.append(habbit)
    }
    func countH() -> Int{
        return self.arrHabbits.count
    }
    func elementNameHabbit(at number: Int) -> Habbit{
        return self.arrHabbits[number]
    }
    func getHabbits() -> [Habbit]{
        return self.arrHabbits
    }
    func deleteHabbit(at offsets: IndexSet){
        self.arrHabbits.remove(atOffsets: offsets)
    }
    func stIndex(habbit: Habbit) -> Int?{
        var number = 0
        for item in self.arrHabbits {
            if item.printName() == habbit.printName() && item.printDescription() == habbit.printDescription(){
                return number
            }
            number += 1
        }
        return nil
    }
}
