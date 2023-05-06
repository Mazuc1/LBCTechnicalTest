//
//  AdsViewModel.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 04/05/2023.
//

import Combine
import UIKit

final class AdsViewModel: ObservableObject {
    // MARK: - Properties

    private let router: AdsRouter
    private let adsFetchingService: AdsFetchingServiceProtocol

    private var cancellables: Set<AnyCancellable> = []

    typealias CollectionViewSnapshot = NSDiffableDataSourceSnapshot<AdsSection, Ad>
    typealias ViewState = ContentState<Content>

    enum Content {
        case `default`(CollectionViewSnapshot)
    }
    
    var adCategories: [AdCategory] = []
    var adsSubject: PassthroughSubject<[Ad], Never> = .init()

    @Published var viewState: ViewState = .loading

    // MARK: - Init

    init(router: AdsRouter,
         adsFetchingService: AdsFetchingServiceProtocol)
    {
        self.router = router
        self.adsFetchingService = adsFetchingService
    }

    // MARK: - Methods
    
    func refreshDatas() {
        viewState = .loading
        
        Publishers.CombineLatest(adsFetchingService.fetchAds(),
                                 adsFetchingService.fetchAdCategories())
        .receive(on: RunLoop.main)
        .sink { [weak self] completion in
            switch completion {
            case .failure: self?.viewState = .error(AdsFetchingService.AdsFetchingServiceError.unknowError)
            case .finished: print("Finished")
            }
        } receiveValue: { [weak self] (ads, adCategories) in
            self?.adsSubject.send(ads)
            self?.adCategories = adCategories
        }
        .store(in: &cancellables)
    }
    
    func bindDataSources() {
        let _makeCollectionViewDefaultSnapshot = makeCollectionViewDefaultSnapshot
        
        adsSubject
            .sink { [weak self] ads in
                let snapshot = _makeCollectionViewDefaultSnapshot(ads)
                self?.viewState = .loaded(.default(snapshot))
            }
            .store(in: &cancellables)
    }

    private func makeCollectionViewDefaultSnapshot(ads: [Ad]) -> CollectionViewSnapshot {
        var snapshot: CollectionViewSnapshot = .init()

        let notUrgentAds = ads
            .filter { !$0.isUrgent }
            .sorted { $0.creationDate > $1.creationDate }

        let urgentAds = ads
            .filter { $0.isUrgent }
            .sorted { $0.creationDate > $1.creationDate }

        let sortedAds = urgentAds + notUrgentAds

        snapshot.appendSections([.main])
        snapshot.appendItems(sortedAds)
        return snapshot
    }
}
