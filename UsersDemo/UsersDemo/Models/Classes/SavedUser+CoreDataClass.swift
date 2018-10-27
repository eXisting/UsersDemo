//
//  SavedUser+CoreDataClass.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/27/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//
//

import UIKit
import CoreData


public class SavedUser: NSManagedObject, UserProtocol {
    
    var image: UIImage?
    var profileImage: UIImage?
    
    var imageWrapper: UserImageWrapper?
    

}
