//
//  Router.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

protocol Closable: AnyObject {
    func close()
    func close(completion: (() -> Void)?)
}

protocol Dismissable: AnyObject {
    func dismiss()
    func dismiss(completion: (() -> Void)?)
}

protocol Routable: AnyObject {
    func route(to viewController: UIViewController,
               as transition: Transition)
    func route(to viewController: UIViewController,
               as transition: Transition,
               completion: (() -> Void)?)
}

protocol Router: Routable {
    var rootViewController: UIViewController? { get set }
}
