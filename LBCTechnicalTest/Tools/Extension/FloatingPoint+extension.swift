//
//  FloatingPoint+extension.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 08/05/2023.
//

import Foundation

extension FloatingPoint {
    var isInteger: Bool { rounded() == self }
}
