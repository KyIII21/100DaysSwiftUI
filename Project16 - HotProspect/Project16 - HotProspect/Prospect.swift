//
//  Prospect.swift
//  Project16 - HotProspect
//
//  Created by Дмитрий on 20.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    // Can Read but write only from this file
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    //@Published var people: [Prospect]
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"

    init() {
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
        
        let filename = Self.getDocumentsDirectory().appendingPathComponent(Self.saveKey)

        do {
            let data = try Data(contentsOf: filename)
            self.people = try JSONDecoder().decode([Prospect].self, from: data)
            return
        } catch {
            print("Unable to load saved data.")
        }

        self.people = []
    }
    
//    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
//        }
//    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func saveData() {
        do {
            let filename = Self.getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        //save()
        saveData()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        //save()
        saveData()
    }
}
