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
        let adsViewModel = AdsViewModel(router: router,
                                        adsFetchingService: AdsFetchingService())
        let rootViewController = AdsViewController(viewModel: adsViewModel)
        router.rootViewController = rootViewController

        return UINavigationController(rootViewController: rootViewController)
    }
}
