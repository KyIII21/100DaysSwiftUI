//
//  Ship+CoreDataProperties.swift
//  Project12 - CoreData
//
//  Created by Дмитрий on 09.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData


extension Ship {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ship> {
        return NSFetchRequest<Ship>(entityName: "Ship")
    }

    @NSManaged public var name: String?
    @NSManaged public var universe: String?

}
