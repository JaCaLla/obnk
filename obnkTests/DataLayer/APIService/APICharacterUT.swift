//
//  APICharacterUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 27/12/22.
//

@testable import obnk
import XCTest

final class APICharacterUT: XCTestCase {

    var sut: APICharacter!
    
    override func setUpWithError() throws {
        sut = APICharacter()
    }

    func testURL() throws {
        guard let url = sut.getURL(page: 0) else {
            XCTFail("testURL: Error fetching URL")
            return
        }
        XCTAssertEqual(url.description,
                       "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=c6293688547662bf5d1cbdb01b7ef97a&hash=5dfa39a27301e2eb8926cfb3a3c04132&offset=0&limit=20")
        
    }
    
    func testGetCommand() {
        XCTAssertEqual(sut.getCommnad(), "characters")
    }
    
    func testFetchSuccessFully() {
        let expectation = XCTestExpectation()
        
        sut.fetch(page: 0) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("testFetchSuccessFully: Unexpected errror")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 100.0)
    }
    
    func testErrorFetching() {
        let expectation = XCTestExpectation()
        // Given
        let urlSessionMock = URLSessionMock()
        urlSessionMock.error = APIManagerError.fetching
        
        sut = APICharacter(urlSession: urlSessionMock)
        XCTAssertEqual(urlSessionMock.urlSessionDataTaskMock.resumeWasCalled, false)
        // When
        sut.fetch(page: 0) { result in
            // Then
            if case let .failure(error) = result, let error = error as? APIManagerError {
                XCTAssertEqual(error, APIManagerError.fetching)
            } else {
                XCTFail("testErrorFetching: No properly error fetched")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testErrorNoData() {
        let expectation = XCTestExpectation()
        // Given
        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = nil
        
        sut = APICharacter(urlSession: urlSessionMock)
        XCTAssertEqual(urlSessionMock.urlSessionDataTaskMock.resumeWasCalled, false)
        // When
        sut.fetch(page: 0) { result in
            // Then
            if case let .failure(error) = result, let error = error as? APIManagerError {
                XCTAssertEqual(error, APIManagerError.noData)
            } else {
                XCTFail("testErrorNoData: No properly error fetched")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testErrorJSONDecoding() {
        let expectation = XCTestExpectation()
        // Given
        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = Data()

        sut = APICharacter(urlSession: urlSessionMock)
        XCTAssertEqual(urlSessionMock.urlSessionDataTaskMock.resumeWasCalled, false)
        // When
        sut.fetch(page: 0) { result in
            // Then
            if case let .failure(error) = result, let error = error as? APIManagerError {
                XCTAssertEqual(error, APIManagerError.jsonDecoding)
            } else {
                XCTFail("testErrorJSONDecoding: No properly error fetched")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testResumeWasCalled() throws {
        
        let expectation = XCTestExpectation()
        // Given
        let urlSessionMock = URLSessionMock()
        sut = APICharacter(urlSession: urlSessionMock)
        XCTAssertEqual(urlSessionMock.urlSessionDataTaskMock.resumeWasCalled, false)
        // When
        sut.fetch(page: 0) { _ in
            // Then
            XCTAssertEqual(urlSessionMock.urlSessionDataTaskMock.resumeWasCalled, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
