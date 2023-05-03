//
//  AdsRouter.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

final class AdsRouter: DefaultRouter {
    func makeRootViewController() -> UIViewController {
        let router = AdsRouter(rootTransition: EmptyTransition())
        let rootViewController = AdsListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        router.rootViewController = rootViewController

        return UINavigationController(rootViewController: rootViewController)
    }
}