//
//  LBCFont.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

enum LBCFont {
    case boldL
    case boldM
    case boldS

    case demiBoldL
    case demiBoldM
    case demiBoldS

    case mediumL
    case mediumM
    case mediumS

    case lightL
    case lightM
    case lightS

    var font: UIFont {
        switch self {
        case .boldL: return UIFont.urbaneRounded(size: 20, weight: .bold)
        case .boldM: return UIFont.urbaneRounded(size: 18, weight: .bold)
        case .boldS: return UIFont.urbaneRounded(size: 16, weight: .bold)
        case .demiBoldL: return UIFont.urbaneRounded(size: 20, weight: .demiBold)
        case .demiBoldM: return UIFont.urbaneRounded(size: 18, weight: .demiBold)
        case .demiBoldS: return UIFont.urbaneRounded(size: 16, weight: .demiBold)
        case .mediumL: return UIFont.urbaneRounded(size: 20, weight: .medium)
        case .mediumM: return UIFont.urbaneRounded(size: 18, weight: .medium)
        case .mediumS: return UIFont.urbaneRounded(size: 16, weight: .medium)
        case .lightL: return UIFont.urbaneRounded(size: 20, weight: .light)
        case .lightM: return UIFont.urbaneRounded(size: 18, weight: .light)
        case .lightS: return UIFont.urbaneRounded(size: 16, weight: .light)
        }
    }
}

enum Font {
    enum Weight {
        case bold, demiBold, medium, light

        var fontSystemName: String {
            switch self {
            case .bold: return "UrbaneRounded-Bold"
            case .demiBold: return "UrbaneRounded-DemiBold"
            case .medium: return "UrbaneRounded-Medium"
            case .light: return "UrbaneRounded-Light"
            }
        }
    }
}
