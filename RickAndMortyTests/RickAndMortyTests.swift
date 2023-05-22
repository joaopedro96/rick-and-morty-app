//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 22/05/23.
//

import XCTest
@testable import RickAndMorty

var systemUnderTest: RMServiceManager!

final class RickAndMortyTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        systemUnderTest = RMServiceManager()
    }

    override func tearDownWithError() throws {
        systemUnderTest = nil
        try super.tearDownWithError()
    }

    func testCharacterRequestApiCallGetsStatusCode200() throws {
        let request = RMRequest.character
        
        let promise = expectation(description: "Status code: 200")
                
        systemUnderTest.getStatusCode(request: request) { statusCode in
            if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(String(describing: statusCode))")
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testEpisodeRequestApiCallGetsStatusCode200() throws {
        let request = RMRequest.episode
        
        let promise = expectation(description: "Status code: 200")
                
        systemUnderTest.getStatusCode(request: request) { statusCode in
            if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(String(describing: statusCode))")
            }
        }
        wait(for: [promise], timeout: 5)
    }
}
