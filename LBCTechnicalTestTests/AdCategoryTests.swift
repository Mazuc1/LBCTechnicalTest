//
//  AdCategoryTests.swift
//  LBCTechnicalTestTests
//
//  Created by Loic Mazuc on 08/05/2023.
//

@testable import LBCTechnicalTest
import XCTest

final class AdCategoryTests: XCTestCase {
    func testThatAdCategoriesCreateFromJSON() {
        // Act
        let adCategories = [AdCategory].createFromJson(sender: self)
        let adCategory = adCategories.first!

        // Assert
        XCTAssertEqual(adCategory.id, 1)
        XCTAssertEqual(adCategory.name, "Véhicule")
    }
}
