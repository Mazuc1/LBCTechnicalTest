//
//  AdsFetchingService.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 04/05/2023.
//

import Combine
import Foundation

protocol AdsFetchingServiceProtocol: AnyObject {
    func fetchAds() -> AnyPublisher<[Ad], Error>
    func fetchAdCategories() -> AnyPublisher<[AdCategory], Error>
}

final class AdsFetchingService: AdsFetchingServiceProtocol {
    //  MARK: - Properties

    private let listEndPoint = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
    private let categoriesEndPoint = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"

    enum AdsFetchingServiceError: Error {
        case cannotBuildURL
        case unknowError
    }

    private let urlSession: URLSession

    // MARK: - Init

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    // MARK: - Methods

    func fetchAds() -> AnyPublisher<[Ad], Error> {
        guard let url = URL(string: listEndPoint) else {
            return Fail(error: AdsFetchingServiceError.cannotBuildURL).eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Ad].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchAdCategories() -> AnyPublisher<[AdCategory], Error> {
        guard let url = URL(string: categoriesEndPoint) else {
            return Fail(error: AdsFetchingServiceError.cannotBuildURL).eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [AdCategory].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
