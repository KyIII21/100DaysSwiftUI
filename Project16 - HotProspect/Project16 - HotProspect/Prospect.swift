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
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
}
