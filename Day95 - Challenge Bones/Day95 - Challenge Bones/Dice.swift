//
//  DIes.swift
//  Day95 - Challenge Bones
//
//  Created by Дмитрий on 29.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

class DiceArray: ObservableObject {
    @Published var diceArr: [Dice]{
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(diceArr) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init(){
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decodeItem = try? decoder.decode([Dice].self, from: items){
                self.diceArr = decodeItem
                return
            }
        }
        self.diceArr = []
    }
    
    func append(dice: Dice){
        diceArr.append(dice)
    }
    func deleteDice(at offsets: IndexSet) {
        var reversedOffsets = IndexSet()
        for offset in offsets {
            reversedOffsets.insert((offset - (self.count() - 1)) * (offsets.first! - (self.count() - 1)).signum())
        }
        diceArr.remove(atOffsets: reversedOffsets)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(diceArr) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
    func count() -> Int{
        return diceArr.count
    }
    func getDice(at index: Int) -> Dice?{
        if index < self.count() && index >= 0{
            return diceArr[index]
        }
        return nil
    }
}

struct Dice: Hashable, Codable {
    private var diceOne: Int8
    private var diceTwo: Int8
    
    var returnDice: String{
        String(diceOne) + " and " + String(diceTwo)
    }
    
    init(_ d1: Int8, _ d2: Int8){
        diceOne = d1
        diceTwo = d2
    }
    
    func sum() -> Int8 {
        return diceOne + diceTwo
    }
}
