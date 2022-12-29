//
//  APIServiceUT.swift
//  obnkTests
//
//  Created by Javier Calatrava on 27/12/22.
//
@testable import obnk
import XCTest

final class APIServiceUT: XCTestCase {

    var sut:APIService<ResponseAPI>!
    
    override func setUpWithError() throws {
        sut = APIService()
    }
    
    func testNoURLBuilt() {
        let expectation = XCTestExpectation()
        // When, Given
        sut.fetch(page: 0) { result in
            // Then
            if case let .failure(error) = result, let error = error as? APIManagerError {
                XCTAssertEqual(error, APIManagerError.noURLBuilt)
                expectation.fulfill()
            } else {
                XCTFail("testNoURLBuilt: No properly error fetched")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
// MARK: - Mock
final class APIServiceMock: APIService<ResponseAPI> {
    
    override func getURL(page: Int? = nil) -> URL? {
        return nil
    }
}

final class URLSessionMock: URLSession {
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    var urlSessionDataTaskMock: URLSessionDataTaskMock = URLSessionDataTaskMock { }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        urlSessionDataTaskMock = URLSessionDataTaskMock {[weak self] in
            completionHandler(self?.data, self?.urlResponse, self?.error)
        }
        return urlSessionDataTaskMock
    }
}

final class URLSessionDataTaskMock: URLSessionDataTask {
    
    private let closure: () -> Void
    
    public var resumeWasCalled = false
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        resumeWasCalled = true
        closure()
    }
}
