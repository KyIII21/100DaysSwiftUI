//
//  Card.swift
//  Project17 - Flashzilla
//
//  Created by Дмитрий on 22.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
