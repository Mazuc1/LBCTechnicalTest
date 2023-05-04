//
//  EmptyTransition.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

public final class EmptyTransition {
    public var isAnimated: Bool = true
    public init() {}
}

extension EmptyTransition: Transition {
    public func open(_: UIViewController,
                     from _: UIViewController,
                     completion _: (() -> Void)?) {}
    public func close(_: UIViewController,
                      completion _: (() -> Void)?) {}
}
