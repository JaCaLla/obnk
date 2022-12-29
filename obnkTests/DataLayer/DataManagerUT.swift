//
//  DataManagerUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 28/12/22.
//
@testable import obnk
import XCTest

final class DataManagerUT: XCTestCase {

    var sut: DataManagerProtocol!

    override func setUpWithError() throws {
        sut = DataManager()
    }

    func testNoOKError() throws {
        let expectation = XCTestExpectation()
        // Given
        let apiCharctersMock = APICharactersMock()
        apiCharctersMock.result = .success(.sampleNotOK)
        sut = DataManager(apiCharcters: apiCharctersMock)
        // When
        sut.fetch { result in
            // Then
            if case let .failure(error) = result, let error = error as? APIManagerError {
                XCTAssertEqual(error, APIManagerError.noOK)
            } else {
                XCTFail("testErrorNoData: No properly error fetched")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPageIncreased() {
        let expectation = XCTestExpectation()
        // Given
        let apiCharctersMock = APICharactersMock()
        apiCharctersMock.result = .success(.sample)
        
        sut = DataManager(apiCharcters: apiCharctersMock)
        guard let dataManager = sut  as? DataManager else {
            XCTFail()
            return
        }
        XCTAssertEqual(dataManager.currentPage, 0)
        // When
        sut.fetch { [weak self] result in
            // Then
            XCTAssertEqual(dataManager.currentPage, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchSuccess() {
        let expectation = XCTestExpectation()
        // Given
        let apiCharctersMock = APICharactersMock()
        apiCharctersMock.result = .success(.sample)
        sut = DataManager(apiCharcters: apiCharctersMock)
        // When
        sut.fetch { result in
            // Then
            if case let .success(characters) = result,
               let characters = characters as? [Character] {
               // XCTAssertEqual(error, APIManagerError.noOK)
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
    
    func testFetchSuccessTwice() {
        let expectation = XCTestExpectation()
        // Given
        let apiCharctersMock = APICharactersMock()
        apiCharctersMock.result = .success(.sample)
        sut = DataManager(apiCharcters: apiCharctersMock)
        guard let dataManager = sut as? DataManager else {
            XCTFail()
            return
        }
        XCTAssertEqual(dataManager.currentPage, 0)
        XCTAssertEqual(dataManager.charactersFetched.count, 0)
        // When
        sut.fetch {[weak self] result in
            XCTAssertEqual(dataManager.currentPage, 1)
            XCTAssertEqual(dataManager.charactersFetched.count, 20)
            self?.sut.fetch { result in
                XCTAssertEqual(dataManager.currentPage, 2)
                XCTAssertEqual(dataManager.charactersFetched.count, 40)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testReset() {
        let expectation = XCTestExpectation()
        // Given
        let apiCharctersMock = APICharactersMock()
        apiCharctersMock.result = .success(.sample)
        sut = DataManager(apiCharcters: apiCharctersMock)
        guard let dataManager = sut as? DataManager  else {
            XCTFail()
            return
        }
        sut.fetch { [weak self] result in
        
            XCTAssertEqual(dataManager.charactersFetched.count, 20)
            XCTAssertEqual(dataManager.currentPage, 1)
            let apiCharctersReference = dataManager.apiCharcters
            // When
            self?.sut.reset()
            // Then
            XCTAssertEqual(dataManager.charactersFetched.count, 0)
            XCTAssertEqual(dataManager.currentPage, 0)
            XCTAssertFalse(apiCharctersReference === dataManager.apiCharcters)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}


final class APICharactersMock: APIService<ResponseAPI> {

    var result: Result<ResponseAPI, Error> = .success(.sampleNotOK)

    // MARK: - To override
    override func getCommnad() -> String {
        return "characters"
    }

    override func fetch(page: Int? = nil, completion: @escaping (Result<ResponseAPI, Error>) -> Void) {
        completion(result)
    }
}
