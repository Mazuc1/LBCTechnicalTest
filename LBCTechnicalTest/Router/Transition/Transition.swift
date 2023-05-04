//
//  Transition.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

public protocol Transition: AnyObject {
    var isAnimated: Bool { get set }
    func open(_ viewController: UIViewController,
              from: UIViewController,
              completion: (() -> Void)?)
    func close(_ viewController: UIViewController,
               completion: (() -> Void)?)
}
