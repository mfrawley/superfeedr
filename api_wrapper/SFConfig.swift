//
//  SFConfig.swift
//  api_wrapper
//
//  Created by Mark on 06.04.15.
//  Copyright (c) 2015 superfeedr. All rights reserved.
//

import UIKit

public struct SFConfigData {
    var username : String;
    var password : String;
    var baseUrl  : String = "http://push.superfeedr.com/";
    
    public init() {
        username = "mfrawley"
        password = "39effe1e43ae713249461eb73c0bedcb"
    }
}