//
//  CharactersPresenterUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 28/12/22.
//
@testable import obnk
import XCTest

final class CharactersPresenterUT: XCTestCase {

    var sut: CharactersPresenterProtocol!

    override func setUpWithError() throws {
        sut = CharactersPresenter()
        currentApp.dataManager.reset()
    }
    
    func testFetchWhenSuccess() {
        
        let expectation = XCTestExpectation()
        
        let interactor = CharactersInteractorMock()
        interactor.result = .success(.sample)
        
        sut = CharactersPresenter(interactor: interactor)
        XCTAssertEqual(interactor.getCharacters().count, 0)
        
        // When
        sut.fetch {result in
            // Then
            XCTAssertEqual(interactor.fetchWasCalled, true)
            
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
    
//    func testNumberOfRowsInSection() {
//
//        let expectation = XCTestExpectation()
//        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 0), 0)
//
//        // When
//        sut.fetch {[weak self] result in
//            // Then
//            XCTAssertEqual(self?.sut.tableView(UITableView(), numberOfRowsInSection: 0), 20)
//            self?.sut.fetch {[weak self] result in
//                // Then
//                XCTAssertEqual(self?.sut.tableView(UITableView(), numberOfRowsInSection: 0), 40)
//                self?.sut.fetch {[weak self] result in
//                    // Then
//                    XCTAssertEqual(self?.sut.tableView(UITableView(), numberOfRowsInSection: 0), 60)
//                    expectation.fulfill()
//                }
//            }
//        }
//        wait(for: [expectation], timeout: 5.0)
//    }
    // func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func testHasToFetch() {
  
        let expectation = XCTestExpectation()
       // XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 0), 0)
        XCTAssertEqual(sut.hasToRequestFetch(indexPath: IndexPath(row: 0, section: 0)), true)
        
        
        // When
        sut.fetch {[weak self] result in
            // Then
            XCTAssertEqual(self?.sut.hasToRequestFetch(indexPath: IndexPath(row: 0, section: 0)), false)
            XCTAssertEqual(self?.sut.hasToRequestFetch(indexPath: IndexPath(row: 18, section: 0)), false)
            XCTAssertEqual(self?.sut.hasToRequestFetch(indexPath: IndexPath(row: 19, section: 0)), true)
            XCTAssertEqual(self?.sut.hasToRequestFetch(indexPath: IndexPath(row: 20, section: 0)), true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
//    func testCellForRowAt() {
//        let expectation = XCTestExpectation()
//        // Given
//        let charactersListView = CharactersListView(frame: .zero)
//        charactersListView.register(CharactersListViewCell.self, forCellReuseIdentifier: "CharactersListViewCell")
//        // When
//        sut.fetch {[weak self] result in
//            // Then
//            let cell = self?.sut.tableView(charactersListView, cellForRowAt: IndexPath(item: 0, section: 0))
//            guard cell is CharactersListViewCell else {
//                XCTFail()
//                expectation.fulfill()
//                return
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 2.0)
//    }
    
//    func testCellForRowAtWhenCellIsNotRegistered() {
//        let expectation = XCTestExpectation()
//        // Given
//        let charactersListView = CharactersListView(frame: .zero)
//        // When
//        sut.fetch {[weak self] result in
//            // Then
//            let cell = self?.sut.tableView(charactersListView, cellForRowAt: IndexPath(item: 0, section: 0))
//            guard cell is CharactersListViewCell else {
//                expectation.fulfill()
//                return
//            }
//            XCTFail()
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 20.0)
//    }
}

final class CharactersInteractorMock: CharactersInteractorProtocol {
    
    var result: Result<[Character],Error> = .success(.sample)
    
    var fetchWasCalled = false
    var getCharactersWasCalled = false
    
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void) {
        fetchWasCalled = true
        completion(result)
    }
    
    func getCharacters() -> [Character] {
        getCharactersWasCalled = true
        return []
    }
}
