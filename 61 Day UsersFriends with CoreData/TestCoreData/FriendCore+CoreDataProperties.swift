//
//  FriendCore+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Дмитрий on 14.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData


extension FriendCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendCore> {
        return NSFetchRequest<FriendCore>(entityName: "FriendCore")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var user: NSSet?

}

// MARK: Generated accessors for user
extension FriendCore {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: UserCore)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: UserCore)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}
