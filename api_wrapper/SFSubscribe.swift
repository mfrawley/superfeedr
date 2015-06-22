//
// Created by Mark on 15.03.15.
// Copyright (c) 2015 superfeedr. All rights reserved.
//

import Foundation
//import Alamofire

enum HttpErrorType : ErrorType {
    case ConnectionError
    case TimeoutError
}

public class SFSubscribe : NSObject, NSURLConnectionDataDelegate {

    //var apiEnpoint = "http://push.superfeedr.com/\(user)/\(password)"
//    var baseUrl = "http://push.superfeedr.com/"
//    var user     = "mfrawley"
//    var password = "39effe1e43ae713249461eb73c0bedcb"
    var configData : SFConfigData;
    var responseBlob : NSMutableData;
    
    public init(data : SFConfigData) {
        self.configData = data
        self.responseBlob = NSMutableData()
    }

    func getAuthHeader(configData : SFConfigData) -> String {
        let plainString = "\(configData.username):\(configData.password)" as NSString
        let plainData = plainString.dataUsingEncoding(NSUTF8StringEncoding)
        let encodingOpts = NSDataBase64EncodingOptions(rawValue: 0)
        let base64String = plainData?.base64EncodedStringWithOptions(encodingOpts)
        return base64String!
    }
    
    
    //List subscriptions for this user
    public func list(numItems: Int, completion:(NSData?, NSURLResponse?, NSError?) -> Void) throws {
        let params = buildParams(getAuthHeader(self.configData),
            mode: SubscribeMode.List,
            page: 1,
            byPage: numItems,
            detailed: true)
        try makeGETRequest(params, completion: completion)
    }

    public func retrieve(count : Int, completion:(NSData?, NSURLResponse?, NSError?) -> Void ) throws {
        let params = [
            "authorization" : getAuthHeader(self.configData)
            , "hub.mode"    : SubscribeMode.Retrieve.rawValue
            , "count"       : count.description
            
        ]
        try makeGETRequest(params, completion: completion)
    }

    public func subscribe(topic : NSURL, callbackUrl: NSURL, completion:(NSData?, NSURLResponse?, NSError?) -> Void ) throws {
        let params = [
            "authorization" : getAuthHeader(self.configData)
            , "hub.mode"    : SubscribeMode.Subscribe.rawValue
            , "hub.topic"   : topic.absoluteString
            , "hub.callback" : callbackUrl.absoluteString
            
        ]
        try makePOSTRequest(params, completion: completion)
    }
    
    func buildParams(authorization : String, mode : SubscribeMode, page : Int, byPage : Int, detailed : Bool)
        -> Dictionary<String,String>
    {
        let params = [
              "authorization" : authorization
            , "hub.mode"      : mode.rawValue
            , "page"          : page.description
            , "by_page"       : byPage.description
            , "detailed"      : detailed.description
        ]
        
        return params
    }
    
    public func makePOSTRequest(params: Dictionary<String,String>, completion:(NSData?, NSURLResponse?, NSError?) -> Void) throws {
        let url = NSURLComponents(string: "")
        for (k,v) in params {
            let item = NSURLQueryItem(name: k, value: v)
            url?.queryItems?.append(item)
        }

        let req = NSMutableURLRequest(URL:NSURL(string: self.configData.baseUrl)!)
        req.HTTPMethod = "POST"
        req.HTTPBody = url?.percentEncodedQuery?.dataUsingEncoding(NSUTF8StringEncoding)!
        let sess = NSURLSession.sharedSession()
        let task = sess.dataTaskWithRequest(req, completionHandler: { data, response, error -> Void in
            completion(data, response, error)
        })
        if task != nil {
            task?.resume()
        } else {
            print("error")
        }
    }

    public func makeGETRequest(params: Dictionary<String,String>, completion:(NSData?, NSURLResponse?, NSError?) -> Void) throws {
        let url = NSURLComponents(string: self.configData.baseUrl)
//        params.enumerate().flatMap(transform: ()
        
        for (k,v) in params {
            let item = NSURLQueryItem(name: k, value: v)
            if url?.queryItems == nil {
                url!.queryItems = []
            }
            url!.queryItems!.append(item)
        }
        
        let req = NSMutableURLRequest(URL:(url?.URL!)!)
        req.HTTPMethod = "GET"
        req.HTTPShouldHandleCookies = false

//        var cnf = NSURLSessionConfiguration()
//        cnf.HTTPCookieStorage
        let sess = NSURLSession.sharedSession()
        let task = sess.dataTaskWithRequest(req, completionHandler: { data, response, error -> Void in
            completion(data, response, error)
        })
        if task != nil {
            task!.resume()
        } else {
            print("error")
        }
    }
    
}
