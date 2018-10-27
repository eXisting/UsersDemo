//
//  UsersWrapper.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/25/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

struct UsersWrapper {
    
    var users: [UserProtocol]?
    var count: Int?
    var next: String?
    
    init(users: [UserProtocol]?, _ count: Int?, _ next: String?) {
        self.count = count
        self.next = next
        self.users = users
    }
}
