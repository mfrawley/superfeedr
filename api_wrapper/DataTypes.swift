//
//  DataTypes.swift
//  api_wrapper
//
//  Created by Mark Frawley on 26/04/2015.
//  Copyright (c) 2015 superfeedr. All rights reserved.
//

import Foundation

enum SubscribeMode : String  {
    case List        = "list"
    case Subscribe   = "subscribe"
    case Unsubscribe = "unsubsribe"
    case Retrieve    = "retrieve"
}

public struct FeedEntryMetaData {
    public var url_site = ""
    public var url_feed = ""
    public var title = ""
    public var desc = ""
    
    public init(title:String, desc:String, urlSite: String, urlFeed: String) {
        self.url_site = urlSite
        self.url_feed = urlFeed
        self.title    = title
        self.desc     = desc
    }
}

public typealias FeedList = Array<FeedEntryMetaData>

public enum FeedOutputFormat : String {
    case Json = "json"
    case Atom = "atom"
}