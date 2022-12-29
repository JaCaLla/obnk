//
//  CharactersInteractorUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 28/12/22.
//
@testable import obnk
import XCTest

final class CharactersInteractorUT: XCTestCase {

    var sut: CharactersInteractorProtocol!

    override func setUpWithError() throws {
        sut = CharactersInteractor()
    }

    func testWhenSuccess() throws {
        let expectation = XCTestExpectation()
        // Given
        let dataManagerMock = DataManagerMock()
        dataManagerMock.result = .success(.sample)
        sut = CharactersInteractor(dataManager: dataManagerMock)
        XCTAssertEqual(sut.getCharacters().count, 0)
        // When
        sut.fetch {[weak self] result in
            XCTAssertEqual(self?.sut.getCharacters().count, 20)
            // Then
            if case let .success(characters) = result {
                XCTAssertEqual(characters.count, 20)
                XCTAssertEqual(characters[0].id, 1011334)
                XCTAssertEqual(characters[0].name, "3-D Man")
                XCTAssertEqual(characters[0].thumbnail.url, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
                XCTAssertEqual(characters[0].comics[0].name, "Avengers: The Initiative (2007) #14")
                XCTAssertEqual(characters[0].comics[1].name, "Avengers: The Initiative (2007) #14 (SPOTLIGHT VARIANT)")
                XCTAssertEqual(characters[0].comics[2].name, "Avengers: The Initiative (2007) #15")
                XCTAssertEqual(characters[0].comics[3].name, "Avengers: The Initiative (2007) #16")
                XCTAssertEqual(characters[0].comics[4].name, "Avengers: The Initiative (2007) #17")
            } else {
                XCTFail("testFetchSuccess")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testWhenDataManagerFails() {
        let expectation = XCTestExpectation()
        // Given
        let dataManagerMock = DataManagerMock()
        dataManagerMock.result = .failure(APIManagerError.noData)
        sut = CharactersInteractor(dataManager: dataManagerMock)
        // When
        sut.fetch { result in
            // Then
            if case let .failure(error) = result, let error = error as? APIManagerError {
                XCTAssertEqual(error, APIManagerError.noData)
            } else {
                XCTFail("testWhenDataManagerFails: No properly error fetched")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
// MARK: - Mock
final class DataManagerMock: DataManagerProtocol {
    var result: Result<[Character], Error> = .success(.sample)
    
    func fetch(completion: @escaping (Result<[obnk.Character], Error>) -> Void) {
        completion(result)
    }
    
    func reset() {
        
    }
}
