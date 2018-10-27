//
//  SavedUser+CoreDataProperties.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/27/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedUser> {
        return NSFetchRequest<SavedUser>(entityName: "SavedUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var phone: String?
    @NSManaged public var fullImage: NSData?
    @NSManaged public var thumbnail: NSData?

}
