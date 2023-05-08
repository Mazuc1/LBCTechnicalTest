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
    let adCategory: AdCategory

    // MARK: - Init

    init(router: AdsRouter,
         ad: Ad,
         adCategory: AdCategory)
    {
        self.router = router
        self.ad = ad
        self.adCategory = adCategory
    }

    func formattedAdDate() -> String {
        guard let date = ad.date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale(identifier: "FR-fr")

        return dateFormatter.string(from: date)
    }
}
