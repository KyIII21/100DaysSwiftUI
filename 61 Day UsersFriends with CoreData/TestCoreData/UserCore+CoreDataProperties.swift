//
//  UserCore+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Дмитрий on 14.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData


extension UserCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCore> {
        return NSFetchRequest<UserCore>(entityName: "UserCore")
    }

    @NSManaged public var about: String
    @NSManaged public var address: String
    @NSManaged public var age: Int16
    @NSManaged public var company: String
    @NSManaged public var email: String
    @NSManaged public var id: UUID
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String
    @NSManaged public var registered: Date?
    @NSManaged public var tags: NSObject?
    @NSManaged public var friend: NSSet?

    var unicTags: [String]{
        var unic = [String]()
        for tag in tags as! [String]{
            if !unic.contains(tag){
                unic.append(tag)
            }
        }
        return unic
    }
}

// MARK: Generated accessors for friend
extension UserCore {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: FriendCore)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: FriendCore)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}
