//
//  UIFont+extension.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import Foundation
import UIKit

extension UIFont {
    class func urbaneRounded(size: CGFloat,
                             weight: Font.Weight) -> UIFont
    {
        UIFont(name: weight.fontSystemName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
