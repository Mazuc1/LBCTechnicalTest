//
//  LBCColor.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import Foundation
import UIKit

enum LBCColor {
    // Ad category colors
    case rose, purple, cyan, lightBlue, royalBlue, red, salmon, green, olive, yellow, orange

    // Text colors
    case ink, inkLight

    // General
    case lightGray

    var color: UIColor {
        switch self {
        case .rose: return UIColor(red: 229 / 255, green: 188 / 255, blue: 218 / 255, alpha: 1)
        case .purple: return UIColor(red: 165 / 255, green: 163 / 255, blue: 243 / 255, alpha: 1)
        case .cyan: return UIColor(red: 142 / 255, green: 212 / 255, blue: 207 / 255, alpha: 1)
        case .lightBlue: return UIColor(red: 161 / 255, green: 207 / 255, blue: 241 / 255, alpha: 1)
        case .royalBlue: return UIColor(red: 107 / 255, green: 174 / 255, blue: 211 / 255, alpha: 1)
        case .red: return UIColor(red: 236 / 255, green: 97 / 255, blue: 97 / 255, alpha: 1)
        case .salmon: return UIColor(red: 254 / 255, green: 170 / 255, blue: 161 / 255, alpha: 1)
        case .green: return UIColor(red: 157 / 255, green: 216 / 255, blue: 148 / 255, alpha: 1)
        case .olive: return UIColor(red: 197 / 255, green: 208 / 255, blue: 129 / 255, alpha: 1)
        case .yellow: return UIColor(red: 250 / 255, green: 123 / 255, blue: 134 / 255, alpha: 1)
        case .orange: return UIColor(red: 231 / 255, green: 188 / 255, blue: 135 / 255, alpha: 1)

        case .ink: return UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
        case .inkLight: return UIColor(red: 90 / 255, green: 90 / 255, blue: 90 / 255, alpha: 1)

        case .lightGray: return UIColor(red: 242.25 / 255, green: 239.7 / 255, blue: 237.15 / 255, alpha: 1)
        }
    }
}
