//
//  DesignSystem.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import Foundation

struct DS {
    static let defaultSpacing: CGFloat = 8
    static let defaultRadius: CGFloat = 8

    static func defaultSpacing(factor: CGFloat) -> CGFloat {
        defaultSpacing * factor
    }
}
