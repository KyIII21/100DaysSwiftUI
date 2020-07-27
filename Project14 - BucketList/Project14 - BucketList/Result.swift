//
//  Result.swift
//  Project14 - BucketList
//
//  Created by Дмитрий on 27.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
