//
//  AdsViewControllerTests.swift
//  LBCTechnicalTestTests
//
//  Created by Loic Mazuc on 08/05/2023.
//

@testable import LBCTechnicalTest
import XCTest

final class AdsViewControllerTests: XCTestCase {
    private var adsViewController: AdsViewController!
    
    override func setUp() {
        super.setUp()
        adsViewController = AdsViewController(viewModel: .init(router: .init(rootTransition: EmptyTransition()),
                                                               adsFetchingService: MockAdsFetchingService()))
    }
    
    func testWhenAppliesLoadingStateThenBackgroundOfCollectionViewIsNotNil() {
        // Arrange
        let state = ContentState<(AdsViewModel.CollectionViewSnapshot, AdCategory?)>.loading

        // Act
        adsViewController.apply(state: state)

        // Assert
        XCTAssertNotNil(adsViewController.collectionView.backgroundView)
    }
    
    func testWhenAppliesErrorStateThenBackgroundOfCollectionViewIsNotNil() {
        // Arrange
        let state = ContentState<(AdsViewModel.CollectionViewSnapshot, AdCategory?)>.error(TestsError.anyError)

        // Act
        adsViewController.apply(state: state)

        // Assert
        XCTAssertNotNil(adsViewController.collectionView.backgroundView)
    }
    
    func testWhenAppliesLoadedStateWithNotEmptySnapshotThenBackgroundOfCollectionViewIsNil() {
        // Arrange
        let state = ContentState<(AdsViewModel.CollectionViewSnapshot, AdCategory?)>.loaded((createSnapshot(), nil))

        // Act
        adsViewController.apply(state: state)

        // Assert
        XCTAssertNil(adsViewController.collectionView.backgroundView)
    }
    
    func testWhenAppliesLoadedStateWithEmptySnapshotThenBackgroundOfCollectionViewIsNotNil() {
        // Arrange
        let state = ContentState<(AdsViewModel.CollectionViewSnapshot, AdCategory?)>.loaded((createSnapshot(isEmpty: true), nil))

        // Act
        adsViewController.apply(state: state)

        // Assert
        XCTAssertNotNil(adsViewController.collectionView.backgroundView)
    }
    
    func testWhenAppliesLoadedStateWithNotNilAdCategoryThenCancelCategoryButtonIsShown() {
        // Arrange
        let adCategory = AdCategory(id: 1, name: "")
        let state = ContentState<(AdsViewModel.CollectionViewSnapshot, AdCategory?)>.loaded((createSnapshot(), adCategory))

        // Act
        adsViewController.apply(state: state)

        // Assert
        XCTAssertFalse(adsViewController.buttonCancelAdsFilter.isHidden)
    }
    
    func testWhenAppliesLoadedStateWithNilAdCategoryThenCancelCategoryButtonIsHidden() {
        // Arrange
        let state = ContentState<(AdsViewModel.CollectionViewSnapshot, AdCategory?)>.loaded((createSnapshot(), nil))

        // Act
        adsViewController.apply(state: state)

        // Assert
        XCTAssertTrue(adsViewController.buttonCancelAdsFilter.isHidden)
    }
}

extension AdsViewControllerTests {
    private func createSnapshot(isEmpty: Bool = false) -> AdsViewModel.CollectionViewSnapshot {
        var snapshot: AdsViewModel.CollectionViewSnapshot = .init()
        var ads: [Ad] = [.init(id: 1, categoryId: 1, title: "", description: "", price: 1, creationDate: "", imagesURL: .init(), isUrgent: false)]
        
        if isEmpty { ads.removeAll() }

        snapshot.appendSections([.main])
        snapshot.appendItems(ads)
        return snapshot
    }
}
