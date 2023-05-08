//
//  AdsFetchingServiceTests.swift
//  LBCTechnicalTestTests
//
//  Created by Loic Mazuc on 02/05/2023.
//

import Combine
@testable import LBCTechnicalTest
import XCTest

final class AdsFetchingServiceTests: XCTestCase {
    private var adsFetchingService: AdsFetchingServiceProtocol!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        adsFetchingService = AdsFetchingService(urlSession: URLSession(configuration: configuration))
    }

    func testWhenFetchingAdsWithoutErrorThenAdsIsReturned() {
        // Arrange
        let expectation = XCTestExpectation(description: #function)
        let sampleData = [Ad(id: 1,
                             categoryId: 1,
                             title: "",
                             description: "",
                             price: 1,
                             creationDate: "",
                             imagesURL: .init(),
                             isUrgent: false)]

        let mockData = try! JSONEncoder().encode(sampleData)

        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), mockData)
        }

        // Act
        adsFetchingService.fetchAds()
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure: XCTFail()
                }
            } receiveValue: { ads in
                // Assert
                XCTAssertFalse(ads.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testWhenFetchingAdsWithErrorThenErrorIsReturned() {
        // Arrange
        let expectation = XCTestExpectation(description: #function)
        let mockData = "Error".data(using: .utf8)!

        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), mockData)
        }

        // Act
        adsFetchingService.fetchAds()
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure:
                    // Assert
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testWhenFetchingAdCategoriesWithoutErrorThenAdCategoriesIsReturned() {
        // Arrange
        let expectation = XCTestExpectation(description: #function)
        let sampleData = [AdCategory(id: 1, name: "Test")]

        let mockData = try! JSONEncoder().encode(sampleData)

        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), mockData)
        }

        // Act
        adsFetchingService.fetchAdCategories()
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure: XCTFail()
                }
            } receiveValue: { categories in
                // Assert
                XCTAssertFalse(categories.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testWhenFetchingAdCategoriesWithErrorThenErrorIsReturned() {
        // Arrange
        let expectation = XCTestExpectation(description: #function)
        let mockData = "Error".data(using: .utf8)!

        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), mockData)
        }

        // Act
        adsFetchingService.fetchAdCategories()
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure:
                    // Assert
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
}
