//
//  Series_PopularesTests.swift
//  Series PopularesTests
//
//  Created by SoSucesso on 12/29/16.
//  Copyright © 2016 Leonardo Simas. All rights reserved.
//

import XCTest
@testable import Series_Populares

class Series_PopularesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIConfig() {
        let apiKey = SeriesDataRequester.sharedInstance.API_KEY
        XCTAssert( apiKey != "", "Falta configurar a API KEY" )
        
        let API_KEY_DEBUG = "1234"
        XCTAssertFalse( apiKey == API_KEY_DEBUG, "Utilizando API KEY de debug, trocar pela key de producao" )
        
    }
    
    func testAPICall() {
        
        let asyncExpectation = expectation(description: "testAPICall")
        
        SeriesDataRequester.sharedInstance.listPopular(page: 1, callback: {seriesResponse, errorMsg in
            
            XCTAssertNil(errorMsg, errorMsg!)
            
            XCTAssertTrue(seriesResponse != nil, "erro no response: SeriesResponse == nil")
            
            asyncExpectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 1, handler: { error in
            XCTAssertNil(error, "erro no timeout")
        })
        
    }
    
}
