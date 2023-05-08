//
//  AdsViewModelTests.swift
//  LBCTechnicalTestTests
//
//  Created by Loic Mazuc on 08/05/2023.
//

@testable import LBCTechnicalTest
import XCTest
import Combine

final class AdsViewModelTests: XCTestCase {
    private var adsViewModel: AdsViewModel!
    private var mockAdsFetchingService: MockAdsFetchingService!
    
    var cancellables: [AnyCancellable] = []

    override func setUp() {
        super.setUp()
        mockAdsFetchingService = .init()
        adsViewModel = .init(router: .init(rootTransition: EmptyTransition()),
                              adsFetchingService: mockAdsFetchingService)
    }
    
    override func tearDown() {
        super.tearDown()
        cancellables.forEach { $0.cancel() }
    }
    
    func testWhenRefreshesAdsThenViewStateIsLoading() {
        // Arrange
        let expectation = self.expectation(description: #function)
        // Set viewState to error (by default it's already loading)
        adsViewModel.viewState = .error(TestsError.anyError)
        
        // Assert
        adsViewModel.$viewState
            .sink(receiveValue: {
                switch $0 {
                case .loading: expectation.fulfill()
                default: break
                }
            })
            .store(in: &cancellables)
        
        // Act
        adsViewModel.refreshDatas()
        
        waitForExpectations(timeout: 2)
    }
    
    func testWhenFetchAdsFailedThenViewStateIsError() {
        // Arrange
        let expectation = self.expectation(description: #function)
        mockAdsFetchingService.isAnErrorThrowFromFetchAds = true
        
        // Assert
        adsViewModel.$viewState
            .sink(receiveValue: {
                switch $0 {
                case .error: expectation.fulfill()
                default: break
                }
            })
            .store(in: &cancellables)
        
        // Act
        adsViewModel.refreshDatas()
        
        waitForExpectations(timeout: 2)
    }
    
    func testWhenFetchAdsSucceedsThenAdsSubjectReceivedAds() {
        // Arrange
        let expectation = self.expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        adsViewModel.bindDataSources()

        // Assert
        adsViewModel.adsSubject
            .collect()
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: {
                expectation.fulfill()
                XCTAssertTrue($0[0].count > 0)
            })
            .store(in: &cancellables)

        // Act
        adsViewModel.refreshDatas()
        DispatchQueue.main.async {
            self.adsViewModel.adsSubject.send(completion: .finished)

        }
        waitForExpectations(timeout: 2)
    }
    
    func testThatAdsIsSortedByEmergencyAndDate() {
        // Arrange
        let returnedAds: [Ad] = [
            .init(id: 1, categoryId: 1, title: "", description: "", price: 1, creationDate: "2019-10-16T17:09:20+0000", imagesURL: .init(), isUrgent: false),
            .init(id: 2, categoryId: 1, title: "", description: "", price: 1, creationDate: "2019-10-16T17:12:20+0000", imagesURL: .init(), isUrgent: true),
            .init(id: 3, categoryId: 1, title: "", description: "", price: 1, creationDate: "2019-10-16T17:08:20+0000", imagesURL: .init(), isUrgent: false),
            .init(id: 4, categoryId: 1, title: "", description: "", price: 1, creationDate: "2019-10-16T17:14:20+0000", imagesURL: .init(), isUrgent: true),
            .init(id: 5, categoryId: 1, title: "", description: "", price: 1, creationDate: "2019-10-16T17:18:20+0000", imagesURL: .init(), isUrgent: true),
        ]
        
        let expectedSortedAds: [Ad] = [returnedAds[4], returnedAds[3], returnedAds[1], returnedAds[0], returnedAds[2]]

        mockAdsFetchingService.expectedReturnWhenFetchingAds = returnedAds
        let expectation = self.expectation(description: #function)
        adsViewModel.bindDataSources()

        // Assert
        adsViewModel.$viewState
            .sink(receiveValue: {
                switch $0 {
                case let .loaded((snapshot, _)):
                    let ads = snapshot.itemIdentifiers(inSection: .main)
                    XCTAssertEqual(ads, expectedSortedAds)
                    expectation.fulfill()
                case .loading: print("Pass")
                default: XCTFail()
                }
            })
            .store(in: &cancellables)

        // Act
        adsViewModel.refreshDatas()

        waitForExpectations(timeout: 2)
    }
    
    func testWhenDidTapFilterAdsThenSnapshotOnlyContainedFilteredAds() {
        // Arrange
        let returnedAds: [Ad] = [
            .init(id: 1, categoryId: 1, title: "", description: "", price: 1, creationDate: "2019-10-16T17:09:20+0000", imagesURL: .init(), isUrgent: false),
            .init(id: 2, categoryId: 2, title: "", description: "", price: 1, creationDate: "2019-10-16T17:12:20+0000", imagesURL: .init(), isUrgent: true),
            .init(id: 3, categoryId: 2, title: "", description: "", price: 1, creationDate: "2019-10-16T17:08:20+0000", imagesURL: .init(), isUrgent: false),
            .init(id: 4, categoryId: 3, title: "", description: "", price: 1, creationDate: "2019-10-16T17:14:20+0000", imagesURL: .init(), isUrgent: true),
            .init(id: 5, categoryId: 4, title: "", description: "", price: 1, creationDate: "2019-10-16T17:18:20+0000", imagesURL: .init(), isUrgent: true),
        ]
        let expectedAdCategory = AdCategory(id: 2, name: "")
        let expectedFilteredAds: [Ad] = [returnedAds[1], returnedAds[2]]

        mockAdsFetchingService.expectedReturnWhenFetchingAds = returnedAds
        let expectation = self.expectation(description: #function)
        adsViewModel.bindDataSources()

        // Assert
        adsViewModel.$viewState
            .sink(receiveValue: {
                switch $0 {
                case let .loaded((snapshot, adCategory)):
                    let ads = snapshot.itemIdentifiers(inSection: .main)
                    XCTAssertEqual(ads, expectedFilteredAds)
                    XCTAssertEqual(expectedAdCategory, adCategory!)
                    expectation.fulfill()
                case .loading: print("Pass")
                default: XCTFail()
                }
            })
            .store(in: &cancellables)

        // Act
        adsViewModel.refreshDatas()
        adsViewModel.didTapFilter(by: expectedAdCategory)

        waitForExpectations(timeout: 2)
    }
}
