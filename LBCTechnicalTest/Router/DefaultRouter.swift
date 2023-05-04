//
//  DefaultRouter.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

open class DefaultRouter: NSObject, Router, Closable, Dismissable {
    private let rootTransition: Transition
    public weak var rootViewController: UIViewController?

    public init(rootTransition: Transition) {
        self.rootTransition = rootTransition
    }

    deinit {
        print("Router \(self.description) deinit")
    }

    // MARK: - Routable

    public func route(to viewController: UIViewController,
                      as transition: Transition,
                      completion: (() -> Void)?)
    {
        guard let root = rootViewController else { return }
        transition.open(viewController,
                        from: root,
                        completion: completion)
    }

    public func route(to viewController: UIViewController,
                      as transition: Transition)
    {
        route(to: viewController,
              as: transition,
              completion: nil)
    }

    // MARK: - Closable

    public func close(completion: (() -> Void)?) {
        guard let root = rootViewController else { return }
        rootTransition.close(root,
                             completion: completion)
    }

    public func close() {
        close(completion: nil)
    }

    // MARK: - Dismissable

    public func dismiss(completion: (() -> Void)?) {
        rootViewController?.dismiss(animated: rootTransition.isAnimated,
                                    completion: completion)
    }

    public func dismiss() {
        dismiss(completion: nil)
    }
}
