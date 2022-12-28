//
//  CharacterDetailCoordinatorUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 28/12/22.
//
@testable import obnk
import XCTest

final class CharacterDetailCoordinatorUT: XCTestCase {

    var sut: CharacterDetailCoordinator!

    override func setUpWithError() throws {
        sut = CharacterDetailCoordinator()
    }

    func testStart() throws {
        // Given
        let navigation = UINavigationController()
        XCTAssertEqual(sut.navigationController.viewControllers.count, 0)
        XCTAssertFalse(navigation === sut.navigationController)
        
        // When
        sut.start(navitagionController: navigation, character: .sample)
        
        // Then
        XCTAssertTrue(sut.navigationController === sut.navigationController)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        guard let _ = sut.navigationController.viewControllers.first as? CharacterDetailViewController else {
            XCTFail()
            return
        }
    }
}
