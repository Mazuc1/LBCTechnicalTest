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

struct AdCategory: Codable, Hashable, Equatable {
    var id: Int
    var name: String

    var color: UIColor {
        switch id {
        case 1: return LBCColor.cyan.color
        case 2: return LBCColor.green.color
        case 3: return LBCColor.lightBlue.color
        case 4: return LBCColor.olive.color
        case 5: return LBCColor.orange.color
        case 6: return LBCColor.purple.color
        case 7: return LBCColor.red.color
        case 8: return LBCColor.rose.color
        case 9: return LBCColor.royalBlue.color
        case 10: return LBCColor.salmon.color
        case 11: return LBCColor.yellow.color
        default: return .black
        }
    }

    static var unknow = Self(id: -1, name: "Unknow")
}
