//
//  Router.swift
//  RoutingExample
//
//  Created by Cassius Pacheco on 5/3/20.
//  Copyright © 2020 Cassius Pacheco. All rights reserved.
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
