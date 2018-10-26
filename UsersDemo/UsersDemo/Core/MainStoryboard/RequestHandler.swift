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
    
    // Prevent from creation
    private init() {}
    
    // MARK: API High-level implementation
    
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
    
    class func loadImageAsyncBy(url: String, _ completionHandler: @escaping (Result<UIImage>) -> Void) {
        
        Alamofire.request(url)
            .response { response in
                guard let imageData = response.data else {
                    completionHandler(.failure(RequestError.EndPointError(reason:
                        "Could not get image from image URL returned in search results")))
                    return
                }
                
                guard let result = UIImage(data: imageData) else {
                    completionHandler(.failure(RequestError.EndPointError(reason:
                        "Could not get image from image URL returned in search results")))
                    return
                }
                
                completionHandler(.success(result))
            }
        
    }
    
    // MARK: Class implementation
    
    private class func getUsersFromResponse(_ response: DataResponse<Any>) -> Result<UsersWrapper> {
        
        guard response.result.error == nil else {
            return .failure(response.result.error!)
        }
        
        // make sure we got JSON and it's a dictionary
        guard let json = response.result.value as? [String: Any] else {
            return .failure(RequestError.SerializationError(reason:
                "Didn't get dictionary in response"))
        }
        
        let responseInfo = json["info"] as? [String:Any]
        let responseCount = responseInfo!["results"] as? Int
        
        var data: [User] = []
        if let results = json["results"] as? [[String: Any]] {
            for responseUser in results {
                let usr = User(json: responseUser)
                let wrapper = usr.imageWrapper!
                
                // Move to wrapper
                RequestHandler.loadImageAsyncBy(url: wrapper.getUrlForPreview()) { result in
                    if result.error == nil {
                       guard let img = result.value else {
                            print("Cannot fetch image!")
                            return
                       }
                       usr.image = img
                    } else {
                        print("Error during callback in loadImageAsync")
                    }
                }
                
                let i_URL = wrapper.big ?? wrapper.medium ?? nil
                
                // TODO: Refactor code duplication
                if i_URL != nil {
                    RequestHandler.loadImageAsyncBy(url: i_URL!) { result in
                        if result.error == nil {
                            guard let img = result.value else {
                                print("Cannot fetch image!")
                                return
                            }
                            usr.profileImage = img
                        } else {
                            print("Error during callback in loadImageAsync")
                        }
                    }
                }
                
                data.append(usr)
            }
        }
        
        return .success(UsersWrapper(users: data, responseCount, RequestHandler.buildEndPointUrl()))
        
    }
    
    
    private class func getUsersAtPath(_ path: String, completionHandler: @escaping (Result<UsersWrapper>) -> Void) {
        
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
    
    private class func buildEndPointUrl() -> String {
        
        var url = RequestHandler.endPoint
        
        url.append("/?results=")
        url.append(countPerRequest)
        url.append("&format=")
        url.append(formatRequired)
        
        return url
    }
    
}

