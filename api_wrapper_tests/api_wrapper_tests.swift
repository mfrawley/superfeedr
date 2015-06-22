//
//  api_wrapper_tests.swift
//  api_wrapper_tests
//
//  Created by Mark on 17.06.15.
//  Copyright © 2015 superfeedr. All rights reserved.
//

import XCTest

class api_wrapper_tests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCallback(data: NSData?, res: NSURLResponse?, error: NSError?) -> Void {
        XCTAssertNotNil(data);
        NSLog("res \(0)", res!)
    }
    
    func testSubscribe() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let data = SFConfigData()
        
        let sub = SFSubscribe(data: data)
        
        do {
//            try sub.subscribe(NSURL(string: "https://news.ycombinator.com/rss")!,
//                callbackUrl: NSURL(string: "https://mfrawley.com/callback")!,
//                completion:{ data, res, error in
//                    print(res)
            try sub.list(10, completion: {data, res, error in
                XCTAssert(error == nil)
                XCTAssert(res != nil)
                XCTAssert(data != nil)
                print(res)
            })
            
        } catch HttpErrorType.ConnectionError {
            XCTAssertFalse(true)
        } catch {
            XCTAssertFalse(true)
        }

    }
    
}
