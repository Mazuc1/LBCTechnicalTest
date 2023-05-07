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
    private var refreshCancellables: Set<AnyCancellable> = []

    typealias CollectionViewSnapshot = NSDiffableDataSourceSnapshot<AdsSection, Ad>
    typealias ViewState = ContentState<(CollectionViewSnapshot, AdCategory?)>

    var adsSubject: PassthroughSubject<[Ad], Never> = .init()
    var categorySubject: CurrentValueSubject<AdCategory?, Never> = .init(nil)

    @Published var adCategories: [AdCategory] = []
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
                case .finished: self?.refreshCancellables.removeAll()
                }
            } receiveValue: { [weak self] ads, adCategories in
                self?.adsSubject.send(ads)
                self?.adCategories = adCategories
            }
            .store(in: &refreshCancellables)
    }

    func bindDataSources() {
        let _makeCollectionViewSnapshot = makeCollectionViewSnapshot

        Publishers.CombineLatest(adsSubject, categorySubject)
            .sink { [weak self] ads, category in
                let snapshot = _makeCollectionViewSnapshot(ads, category)
                self?.viewState = .loaded((snapshot, category))
            }
            .store(in: &cancellables)
    }
    
    private func makeCollectionViewSnapshot(ads: [Ad], category: AdCategory?) -> CollectionViewSnapshot {
        var snapshot: CollectionViewSnapshot = .init()
        var filteredAds: [Ad] = []
        
        if let category {
            filteredAds = ads.filter { $0.categoryId == category.id }
        }

        let sortedAds = filteredAds.isEmpty ? sortedAdsByDateAndEmergency(ads: ads) : sortedAdsByDateAndEmergency(ads: filteredAds)

        snapshot.appendSections([.main])
        snapshot.appendItems(sortedAds)
        return snapshot
    }

    private func sortedAdsByDateAndEmergency(ads: [Ad]) -> [Ad] {
        let notUrgentAds = ads
            .filter { !$0.isUrgent }
            .sorted { $0.creationDate > $1.creationDate }

        let urgentAds = ads
            .filter { $0.isUrgent }
            .sorted { $0.creationDate > $1.creationDate }

        return urgentAds + notUrgentAds
    }

    func didTapFilter(by category: AdCategory) {
        categorySubject.send(category)
    }
    
    func didTapCancelFilteredAds() {
        categorySubject.send(nil)
    }
}
