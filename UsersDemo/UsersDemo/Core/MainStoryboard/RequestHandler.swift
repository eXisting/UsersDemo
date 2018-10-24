//
//  RequestHandler.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class RequestHandler {

    private let endPoint = "https://randomuser.me/api"
    private let countPerRequest = "25"
    private let formatRequired = "json"
    
    private func createRequest() {
        var url = endPoint
        url.append("/?results=")
        url.append(countPerRequest)
        url.append("/?format=")
        url.append(formatRequired)
        
        // TODO
    }
    
    static func getUsers() -> [User] {
        
        
        
        return []
    }

}
