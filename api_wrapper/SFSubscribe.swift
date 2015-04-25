//
// Created by Mark on 15.03.15.
// Copyright (c) 2015 superfeedr. All rights reserved.
//

import Foundation
import Alamofire

public class SFSubscribe {

    //var apiEnpoint = "http://push.superfeedr.com/\(user)/\(password)"
//    var baseUrl = "http://push.superfeedr.com/"
//    var user     = "mfrawley"
//    var password = "39effe1e43ae713249461eb73c0bedcb"
    var configData : SFConfigData;
    
    enum SubscribeMode : String  {
        case List        = "list"
        case Subscribe   = "subscribe"
        case Unsubscribe = "unsubsribe"
        case Retrieve    = "retrieve"
    }
    
    public init(data : SFConfigData) {
        self.configData = data;
    }

    func getAuthHeader(configData : SFConfigData) -> String {
        let plainString = "\(configData.username):\(configData.password)" as NSString
        let plainData = plainString.dataUsingEncoding(NSUTF8StringEncoding)
        let encodingOpts = NSDataBase64EncodingOptions(rawValue: 0)
        let base64String = plainData?.base64EncodedStringWithOptions(encodingOpts)
        return base64String!
    }
    
    
    //List subscriptions for this user
    public func list() {
        let params = buildParams(getAuthHeader(self.configData),
            mode: SubscribeMode.List,
            page: 1,
            byPage: 20,
            detailed: true)
        makeRequest(params)
    }

    public func retrieve() {
        let params = [
            "authorization" : getAuthHeader(self.configData)
            , "hub.mode"    : SubscribeMode.Retrieve.rawValue
            , "count"       : "2"
            
        ]
        makeRequest(params)
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
        print(params)
        
        return params
    }
    
    public func makeRequest(params: Dictionary<String,String>) {
        Alamofire.request(.GET, self.configData.baseUrl, parameters:params)
//            .response { (request, response, data, error) in
//                println(response?.description)
//                println(error)
//        }
            .responseJSON { (_, _, JSON, _) in
                println(JSON)
        }
    }
}
