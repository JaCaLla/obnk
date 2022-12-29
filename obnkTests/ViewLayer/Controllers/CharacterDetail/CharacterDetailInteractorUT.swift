//
//  CharacterDetailInteractorUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 28/12/22.
//
@testable import obnk
import XCTest

final class CharacterDetailInteractorUT: XCTestCase {

    var sut: CharacterDetailInteractorProtocol!

    override func setUpWithError() throws {
        let character: Character = .sample
        sut = CharacterDetailInteractor(character: character)

    }


    func testGetCharacter() throws {
        // Give, When, Then
        XCTAssertEqual(sut.getCharacter(), .sample)
    }
}
