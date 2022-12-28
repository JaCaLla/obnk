//
//  CharacterDetailPresenterUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 28/12/22.
//
@testable import obnk
import XCTest

final class CharacterDetailPresenterUT: XCTestCase {

    var sut: CharacterDetailPresenterProtocol!
    var interactor: CharaterDetailInteractorMock!

    override func setUpWithError() throws {
        interactor = CharaterDetailInteractorMock()
        sut = CharacterDetailPresenter(interactor: interactor)
    }

    func testGetTitle() throws {
        // Given, When, Then
        XCTAssertEqual(sut.getTitle(), "3-D Man")
    }

    func testGetImageURL() throws {
        // Given, When, Then
        XCTAssertEqual(sut.getImageURL()?.description, "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
    }

    func testTitleForHeaderInSection() {
        XCTAssertEqual(sut.tableView(UITableView(), titleForHeaderInSection: .comics), "Comic")
    }

    func testCellForRowAt() {
        // Given
        let characterDetailView = CharacterDetailView(frame: .zero)
        characterDetailView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        // When
        // Then
        let cell = sut.tableView(characterDetailView, cellForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "Avengers: The Initiative (2007) #14")
    }
    
    func testCellForRowAtWhenWrongSection() {
        // Given
        let characterDetailView = CharacterDetailView(frame: .zero)
        characterDetailView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        // When
        // Then
        let cell = sut.tableView(characterDetailView, cellForRowAt: IndexPath(item: 0, section: 1))
        XCTAssertNil(cell.textLabel?.text)
    }

    func testCellForRowAtWhenWrongCellId() {
        // Given
        let characterDetailView = CharacterDetailView(frame: .zero)
        characterDetailView.register(UITableViewCell.self, forCellReuseIdentifier: "WrongCellId")
        // When
        // Then
        let cell = sut.tableView(characterDetailView, cellForRowAt: IndexPath(item: 0, section: 1))
        XCTAssertNil(cell.textLabel?.text)
    }
}

final class CharaterDetailInteractorMock: CharacterDetailInteractorProtocol {
    func getCharacter() -> obnk.Character {
            .sample
    }
}
