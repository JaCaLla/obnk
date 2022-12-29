//
//  APICharacterDetailUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 27/12/22.
//
@testable import obnk
import XCTest

final class APICharacterDetailUT: XCTestCase {

    var sut: APICharacterDetail!
    
    override func setUpWithError() throws {
        sut = APICharacterDetail(id: 123)
    }

    func testURL() throws {
        guard let url = sut.getURL(page: 0) else {
            XCTFail("testURL: Error fetching URL")
            return
        }
        XCTAssertEqual(url.description,
                       "https://gateway.marvel.com/v1/public/characters/123?ts=1&apikey=c6293688547662bf5d1cbdb01b7ef97a&hash=5dfa39a27301e2eb8926cfb3a3c04132&offset=0&limit=20")
        
    }
    
    func testGetCommand() {
        XCTAssertEqual(sut.getCommnad(), "characters/123")
    }

    func testFetchPage0SuccessFully() {
        let expectation = XCTestExpectation()
        
        sut.fetch() { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("testFetchSuccessFully: Unexpected errror")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
