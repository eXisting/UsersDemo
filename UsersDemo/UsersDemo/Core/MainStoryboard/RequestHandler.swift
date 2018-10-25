//
//  RequestHandler.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//


import UIKit
import Alamofire

enum RequestError: Error {
    case EndPointError(reason: String)
    case SerializationError(reason: String)
}

class RequestHandler {

    fileprivate static let endPoint = "https://randomuser.me/api"
    fileprivate static let countPerRequest = "15"
    fileprivate static let formatRequired = "json"
    
    // mock
    private init() {}
    
    private class func getUsersFromResponse(_ response: DataResponse<Any>) -> Result<UsersWrapper> {
       
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            print(response.result.error!)
            return .failure(response.result.error!)
        }
        
        // make sure we got JSON and it's a dictionary
        guard let json = response.result.value as? [String: Any] else {
            return .failure(RequestError.SerializationError(reason:
                "Didn't get dictionary in response"))
        }
        
        let wrapper = UsersWrapper()
        let responseInfo = json["info"] as? [String:Any]
        
        // remember response data into wrapper
        wrapper.count = responseInfo!["results"] as? Int
        wrapper.next = RequestHandler.buildEndPointUrl()
        
        var data: [User] = []
        if let results = json["results"] as? [[String: Any]] {
            for responseUser in results {
                data.append(User(json: responseUser))
            }
        }
        
        wrapper.users = data
        return .success(wrapper)
        
    }

    
    fileprivate class func getUsersAtPath(_ path: String, completionHandler: @escaping (Result<UsersWrapper>) -> Void) {
        
        // make sure it's HTTPS
        guard var urlComponents = URLComponents(string: path) else {
            let error = RequestError.EndPointError(reason: "Tried to load an invalid URL")
            completionHandler(.failure(error))
            return
        }
        
        urlComponents.scheme = "https"
        
        guard let url = try? urlComponents.asURL() else {
            let error = RequestError.EndPointError(reason: "Tried to load an invalid URL")
            completionHandler(.failure(error))
            return
        }
        
        let _ = Alamofire.request(url)
            .responseJSON { response in
                
                if let error = response.result.error {
                    completionHandler(.failure(error))
                    return
                }
                
                let usersWrapperResult = RequestHandler.getUsersFromResponse(response)
                completionHandler(usersWrapperResult)
            }
        
    }
    
    class func loadUsers(_ completionHandler: @escaping (Result<UsersWrapper>) -> Void) {
        getUsersAtPath(RequestHandler.buildEndPointUrl(), completionHandler: completionHandler)
    }
    
    class func loadMore(_ wrapper: UsersWrapper?, completionHandler: @escaping (Result<UsersWrapper>) -> Void) {
        
        guard let nextURL = wrapper?.next else {
            let error = RequestError.SerializationError(reason: "Cannot get next url for request")
            completionHandler(.failure(error))
            return
        }
        
        getUsersAtPath(nextURL, completionHandler: completionHandler)
    }
    
    private class func buildEndPointUrl() -> String {
        var url = RequestHandler.endPoint
        url.append("/?results=")
        url.append(countPerRequest)
        url.append("&format=")
        url.append(formatRequired)
        
        return url
    }
    
}

