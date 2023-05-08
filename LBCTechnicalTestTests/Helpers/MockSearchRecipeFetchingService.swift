//
//  MockSearchRecipeFetchingService.swift
//  RecipleaseTests
//
//  Created by Loic Mazuc on 02/09/2022.
//

import Foundation
@testable import LBCTechnicalTest
import Combine

class MockAdsFetchingService: AdsFetchingServiceProtocol {
    var isAnErrorThrowFromFetchAds: Bool = false
    func fetchAds() -> AnyPublisher<[LBCTechnicalTest.Ad], Error> {
        if isAnErrorThrowFromFetchAds {
            return Fail(error: TestsError.anyError).eraseToAnyPublisher()
        } else {
            let ads: [Ad] = [.init(id: 1, categoryId: 1, title: "", description: "", price: 1, creationDate: "", imagesURL: .init(), isUrgent: false)]
            return CurrentValueSubject<[Ad], Error>(ads).eraseToAnyPublisher()
        }
    }
    
    var isAnErrorThrowFromFetchAdCategories: Bool = false
    func fetchAdCategories() -> AnyPublisher<[LBCTechnicalTest.AdCategory], Error> {
        if isAnErrorThrowFromFetchAds {
            return Fail(error: TestsError.anyError).eraseToAnyPublisher()
        } else {
            let adCategories: [AdCategory] = [.init(id: 1, name: "")]
            return CurrentValueSubject<[AdCategory], Error>(adCategories).eraseToAnyPublisher()
        }
    }
}
