//
//  User.swift
//  Day 60 - Challenge3 (ListOfUsersAndFriens)
//
//  Created by Дмитрий on 11.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct User: Codable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int8
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
    
    var registeredDate: Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from:registered)!
    }
    
    var unicTags: [String]{
        var unic = [String]()
        for tag in tags{
            if !unic.contains(tag){
                unic.append(tag)
            }
        }
        return unic
    }
    
    struct Friend: Codable, Hashable{
        var id: UUID
        var name: String
    }
    
}


