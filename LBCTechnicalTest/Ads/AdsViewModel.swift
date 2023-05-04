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

    var destinationsSubject: PassthroughSubject<[Ad], Never> = .init()

    @Published var viewState: ViewState = .loading

    // MARK: - Init

    init(router: AdsRouter,
         adsFetchingService: AdsFetchingServiceProtocol)
    {
        self.router = router
        self.adsFetchingService = adsFetchingService
    }

    // MARK: - Methods

    func bindDataSources() {
        viewState = .loading

        let _makeCollectionViewDefaultSnapshot = makeCollectionViewDefaultSnapshot

        adsFetchingService.fetchAds()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure: self?.viewState = .error(AdsFetchingService.AdsFetchingServiceError.unknowError)
                case .finished: print("Finished")
                }
            } receiveValue: { [weak self] ads in
                let snapshot = _makeCollectionViewDefaultSnapshot(ads)
                self?.viewState = .loaded(.default(snapshot))
            }
            .store(in: &cancellables)
    }

    private func makeCollectionViewDefaultSnapshot(ads: [Ad]) -> CollectionViewSnapshot {
        var snapshot: CollectionViewSnapshot = .init()
        snapshot.appendSections([.main])
        snapshot.appendItems(ads)
        return snapshot
    }
}
