//
//  AdTests.swift
//  LBCTechnicalTestTests
//
//  Created by Loic Mazuc on 08/05/2023.
//

import XCTest
@testable import LBCTechnicalTest

final class AdTests: XCTestCase {
    func testThatAdsCreateFromJSON() {
        // Act
        let ads = [Ad].createFromJson(sender: self)
        let ad = ads.first!

        // Assert
        XCTAssertEqual(ad.id, 1461267313)
        XCTAssertEqual(ad.categoryId, 4)
        XCTAssertEqual(ad.title, "Statue homme noir assis en plâtre polychrome")
        XCTAssertEqual(ad.description, "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible")
        XCTAssertEqual(ad.price, 140.0)
        XCTAssertEqual(ad.creationDate, "2019-11-05T15:56:59+0000")
        XCTAssertEqual(ad.isUrgent, false)
        XCTAssertEqual(ad.imagesURL.small!, URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"))
        XCTAssertEqual(ad.imagesURL.thumb!, URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"))
    }
    
    func testThatGoodCategoryIDReturnsGoodAdCategory() {
        // Arrange
        let ad = Ad(id: 1,
                    categoryId: 2,
                    title: "",
                    description: "",
                    price: 1,
                    creationDate: "",
                    imagesURL: .init(),
                    isUrgent: false)
        let adCategories: [AdCategory] = [.init(id: 1, name: "1"), .init(id: 2, name: "2")]
        
        // Act
        let category = ad.category(in: adCategories)
        
        // Assert
        XCTAssertEqual(category.id, 2)
        XCTAssertEqual(category.name, "2")
    }
    
    func testThatBadCategoryIDReturnsUnknowAdCategory() {
        // Arrange
        let ad = Ad(id: 1,
                    categoryId: 2,
                    title: "",
                    description: "",
                    price: 1,
                    creationDate: "",
                    imagesURL: .init(),
                    isUrgent: false)
        let adCategories: [AdCategory] = [.init(id: 1, name: "1")]
        
        // Act
        let category = ad.category(in: adCategories)
        
        // Assert
        XCTAssertEqual(category.id, -1)
        XCTAssertEqual(category.name, "Unknow")
    }
}
