//
//  AdCategory.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 08/05/2023.
//

import UIKit

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
