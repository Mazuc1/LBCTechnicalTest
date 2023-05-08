//
//  Ad.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import Foundation
import UIKit

struct Ad: Codable, Hashable, Equatable {
    var id: Int
    var categoryId: Int
    var title: String
    var description: String
    var price: Float
    var creationDate: String
    var imagesURL: ImagesURL
    var isUrgent: Bool
    var siret: String?

    var date: Date? {
        creationDate.ISO8601toDate()
    }

    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case isUrgent = "is_urgent"
        case creationDate = "creation_date"
        case imagesURL = "images_url"
        case id, title, description, price, siret
    }

    static func == (lhs: Ad, rhs: Ad) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func category(in categories: [AdCategory]) -> AdCategory {
        guard let category = categories.first(where: { $0.id == categoryId }) else {
            return AdCategory.unknow
        }

        return category
    }
}

struct ImagesURL: Codable {
    var small: URL?
    var thumb: URL?
}
