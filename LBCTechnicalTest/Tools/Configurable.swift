//
//  Configurable.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

public protocol Configurable {}

public extension Configurable where Self: Any {
    func configure(block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

public extension Configurable where Self: AnyObject {
    func configure(block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Configurable {}
extension Array: Configurable {}
extension Dictionary: Configurable {}
extension Set: Configurable {}
