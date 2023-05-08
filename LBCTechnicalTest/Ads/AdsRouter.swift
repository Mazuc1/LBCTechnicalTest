//
//  AdsRouter.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

extension AdsRouter {
    struct Environment {
        let adsFetchingService: AdsFetchingServiceProtocol

        init(adsFetchingService: AdsFetchingServiceProtocol) {
            self.adsFetchingService = adsFetchingService
        }
    }
}

final class AdsRouter: DefaultRouter {
    // MARK: - Properties
    
    let environement: Environment
    
    // MARK: - Init

    init(environement: Environment, rootTransition: Transition) {
        self.environement = environement

        super.init(rootTransition: rootTransition)
    }
    
    // MARK: - Methods

    func makeRootViewController() -> UIViewController {
        let router = AdsRouter(environement: environement, rootTransition: EmptyTransition())
        let adsViewModel = AdsViewModel(router: router,
                                        adsFetchingService: environement.adsFetchingService)
        let rootViewController = AdsViewController(viewModel: adsViewModel)
        router.rootViewController = rootViewController

        return UINavigationController(rootViewController: rootViewController)
    }

    func openAdDetails(for ad: Ad, of category: AdCategory) {
        let transition = PushTransition()
        let router = AdsRouter(environement: environement, rootTransition: transition)
        let adDetailsViewModel = AdDetailsViewModel(router: router, ad: ad, adCategory: category)
        let adDetailsViewController = AdDetailsViewController(viewModel: adDetailsViewModel)

        router.rootViewController = adDetailsViewController
        route(to: adDetailsViewController, as: transition)
    }
}
