//
//  APICharacterUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 27/12/22.
//

@testable import obnk
import XCTest

final class APICharactersUT: XCTestCase {

    var sut: APICharacters!
    
    override func setUpWithError() throws {
        sut = APICharacters()
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
    
    func testFetchPage0SuccessFully() {
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
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchSuccessFullyWithMockedData() {
        let expectation = XCTestExpectation(description: "testFetchSuccessFullyWithMockedData")
        // Given
        let urlSessionMock = URLSessionMock()
        
        sut = APICharacters(urlSession: urlSessionMock)
        let path = Bundle.main.path(forResource: "APiCharacters", ofType: "json") ?? ""
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            urlSessionMock.data = data
        } catch {
            XCTFail("Wrong Data fetching")
            return
        }
        // When
        sut.fetch(page: 0) { result in
            switch result {
            case .success(let responseAPICharacters):
               // XCTAssertEqual(responseAPICharacters, .sample)
                
                XCTAssertEqual(responseAPICharacters.status, "Ok")
                XCTAssertEqual(responseAPICharacters.data.offset, 0)
                XCTAssertEqual(responseAPICharacters.data.limit, 20)
                XCTAssertEqual(responseAPICharacters.data.total, 1562)
                XCTAssertEqual(responseAPICharacters.data.count, 20)
                XCTAssertEqual(responseAPICharacters.data.results.count, 20)
                
                XCTAssertEqual(responseAPICharacters.data.results[0].id, 1011334)
                XCTAssertEqual(responseAPICharacters.data.results[0].name, "3-D Man")
                XCTAssertEqual(responseAPICharacters.data.results[0].thumbnail.ext, "jpg")
                XCTAssertEqual(responseAPICharacters.data.results[0].thumbnail.path, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
                XCTAssertEqual(responseAPICharacters.data.results[0].comics.items[0].name, "Avengers: The Initiative (2007) #14")
                
                XCTAssertEqual(responseAPICharacters.data.results[1].id, 1017100)
                XCTAssertEqual(responseAPICharacters.data.results[1].name, "A-Bomb (HAS)")
                XCTAssertEqual(responseAPICharacters.data.results[2].id, 1009144)
                XCTAssertEqual(responseAPICharacters.data.results[2].name, "A.I.M.")
                XCTAssertEqual(responseAPICharacters.data.results[3].id, 1010699)
                XCTAssertEqual(responseAPICharacters.data.results[3].name, "Aaron Stack")
                XCTAssertEqual(responseAPICharacters.data.results[4].id, 1009146)
                XCTAssertEqual(responseAPICharacters.data.results[4].name, "Abomination (Emil Blonsky)")
                XCTAssertEqual(responseAPICharacters.data.results[5].id, 1016823)
                XCTAssertEqual(responseAPICharacters.data.results[5].name, "Abomination (Ultimate)")
                XCTAssertEqual(responseAPICharacters.data.results[6].id, 1009148)
                XCTAssertEqual(responseAPICharacters.data.results[6].name, "Absorbing Man")
                XCTAssertEqual(responseAPICharacters.data.results[7].id, 1009149)
                XCTAssertEqual(responseAPICharacters.data.results[7].name, "Abyss")
                XCTAssertEqual(responseAPICharacters.data.results[8].id, 1010903)
                XCTAssertEqual(responseAPICharacters.data.results[8].name, "Abyss (Age of Apocalypse)")
                XCTAssertEqual(responseAPICharacters.data.results[9].id, 1011266)
                XCTAssertEqual(responseAPICharacters.data.results[9].name, "Adam Destine")
                XCTAssertEqual(responseAPICharacters.data.results[10].id, 1010354)
                XCTAssertEqual(responseAPICharacters.data.results[10].name, "Adam Warlock")
                XCTAssertEqual(responseAPICharacters.data.results[11].id, 1010846)
                XCTAssertEqual(responseAPICharacters.data.results[11].name, "Aegis (Trey Rollins)")
                XCTAssertEqual(responseAPICharacters.data.results[12].id, 1017851)
                XCTAssertEqual(responseAPICharacters.data.results[12].name, "Aero (Aero)")
                XCTAssertEqual(responseAPICharacters.data.results[13].id, 1012717)
                XCTAssertEqual(responseAPICharacters.data.results[13].name, "Agatha Harkness")
                XCTAssertEqual(responseAPICharacters.data.results[14].id, 1011297)
                XCTAssertEqual(responseAPICharacters.data.results[14].name, "Agent Brand")
                XCTAssertEqual(responseAPICharacters.data.results[15].id, 1011031)
                XCTAssertEqual(responseAPICharacters.data.results[15].name, "Agent X (Nijo)")
                XCTAssertEqual(responseAPICharacters.data.results[16].id, 1009150)
                XCTAssertEqual(responseAPICharacters.data.results[16].name, "Agent Zero")
                XCTAssertEqual(responseAPICharacters.data.results[17].id, 1011198)
                XCTAssertEqual(responseAPICharacters.data.results[17].name, "Agents of Atlas")
                XCTAssertEqual(responseAPICharacters.data.results[18].id, 1011175)
                XCTAssertEqual(responseAPICharacters.data.results[18].name, "Aginar")
                XCTAssertEqual(responseAPICharacters.data.results[19].id, 1011136)
                XCTAssertEqual(responseAPICharacters.data.results[19].name, "Air-Walker (Gabriel Lan)")

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
        
        sut = APICharacters(urlSession: urlSessionMock)
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
        
        sut = APICharacters(urlSession: urlSessionMock)
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

        sut = APICharacters(urlSession: urlSessionMock)
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
        sut = APICharacters(urlSession: urlSessionMock)
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
