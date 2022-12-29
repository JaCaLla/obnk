//
//  CharactersCoordinatorUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 28/12/22.
//
@testable import obnk
import XCTest

final class CharactersCoordinatorUT: XCTestCase {

    var sut: CharactersCoordinator!

    override func setUpWithError() throws {
        sut = CharactersCoordinator()
    }

    func testStart() throws {
        // Given
        let navigation = UINavigationController()
        XCTAssertEqual(sut.navigationController.viewControllers.count, 0)
        XCTAssertFalse(navigation === sut.navigationController)
        
        // When
        sut.start(navitagionController: navigation)
        
        // Then
        XCTAssertTrue(sut.navigationController === sut.navigationController)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        guard let _ = sut.navigationController.viewControllers.first as? CharactersViewController else {
            XCTFail()
            return
        }
    }
    
    func testShowDetail() throws {
        // Given
        let navigation = UINavigationController()
        sut.start(navitagionController: navigation)
        guard let charactersViewController = sut.navigationController.viewControllers.first as? CharactersViewController else {
            XCTFail()
            return
        }
        charactersViewController.delegate = sut

        // When
        charactersViewController.showDetail(character: .sample)
        // Let de main thread continues before executing validation
        DispatchQueue.main.async { [weak self] in
            // Then
            XCTAssertEqual(self?.sut.navigationController.viewControllers.count, 2)
            guard let _ = self?.sut.navigationController.viewControllers.last as? CharacterDetailViewController else {
                XCTFail()
                return
            }
        }

    }
}
