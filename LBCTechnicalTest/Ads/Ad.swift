//
//  Ad.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import Foundation

struct Ad: Decodable {
    var id: Int
    var category: AdCategory
    var title: String
    var description: String
    var price: Float
    var creationDate: Date
    var imagesURL: ImagesURL
    var isUrgent: Bool
}

struct ImagesURL: Decodable {
    var small: URL
    var thumb: URL
}

enum AdCategory: Int, Decodable {
    case vehicule = 1
    case mode = 2
    case DIY = 3
    case house = 4
    case hobbies = 5
    case realEstate = 6
    case books = 7
    case multimedia = 8
    case services = 9
    case animals = 10
    case children = 11

    var name: String {
        switch self {
        case .vehicule: return "Véhicule"
        case .mode: return "Mode"
        case .DIY: return "Bricolage"
        case .house: return "Maison"
        case .hobbies: return "Loisirs"
        case .realEstate: return "Immobilier"
        case .books: return "Livres/CD/DVD"
        case .multimedia: return "Multimédia"
        case .services: return "Service"
        case .animals: return "Animaux"
        case .children: return "Enfants"
        }
    }
}

extension Ad {
    static let mockedUrl = URL(string: "https://www.google.fr/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Ffr%2Fphotos%2Fasturies&psig=AOvVaw1OxXuj4HxdiTXVJNu9Snfb&ust=1683228042849000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCNiEqZ7v2f4CFQAAAAAdAAAAABAE")!
    static let mockedDatas: [Ad] = [
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
        .init(id: 1, category: .animals, title: "Chien à vendre", description: "Description", price: 13.00, creationDate: .init(), imagesURL: .init(small: Self.mockedUrl, thumb: Self.mockedUrl), isUrgent: false),
    ]
}
