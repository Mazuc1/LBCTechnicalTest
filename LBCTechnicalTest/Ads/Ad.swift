//
//  Ad.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import Foundation
import UIKit

struct Ad: Decodable, Hashable, Equatable {
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

struct ImagesURL: Decodable {
    var small: URL?
    var thumb: URL?
}

struct AdCategory: Decodable, Hashable, Equatable {
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
    
    static var unknow = Self.init(id: -1, name: "Unknow")
}

//extension Ad {
//    static let mockedUrl = URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!
//    static let mockedDatas: [Ad] = [
//        .init(id: 1, category: .animals, title: "Chien à vendre aaa aaa aa aaa", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 2, category: .DIY, title: "Chien à vendre aaa aaaaaaa a a a a a a a a a a a a", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 3, category: .books, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 4, category: .children, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: true),
//        .init(id: 5, category: .hobbies, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 6, category: .house, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 7, category: .mode, title: "Chien à vendreazezeaze azeazezae azeazeaze azee", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 8, category: .multimedia, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 9, category: .realEstate, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: true),
//        .init(id: 10, category: .services, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 11, category: .vehicule, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 12, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: true),
//        .init(id: 13, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 14, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 15, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 16, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 17, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 18, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 19, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 20, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 21, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 22, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//        .init(id: 23, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
//    ]
//}
