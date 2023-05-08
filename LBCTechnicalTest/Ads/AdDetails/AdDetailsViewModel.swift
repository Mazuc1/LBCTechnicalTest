//
//  AdDetailsViewModel.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 08/05/2023.
//

import Foundation

final class AdDetailsViewModel {
    // MARK: - Properties

    private let router: AdsRouter
    let ad: Ad

    // MARK: - Init

    init(router: AdsRouter,
         ad: Ad)
    {
        self.router = router
        self.ad = ad
    }
}
