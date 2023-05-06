//
//  AdsGridViewController.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import Combine
import UIKit

enum AdsSection {
    case main
}

final class AdsGridViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: AdsViewModel

    static let adCellImagesCache: NSCache<NSNumber, UIImage> = {
        let cache = NSCache<NSNumber, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 50 * 1024 * 1024 // 50MB
        return cache
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<AdsSection, Ad> = createDataSource()

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - UI

    private lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: createLayout()).configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LBCColor.lightGray.color
    }

    // MARK: - Init

    required init(viewModel: AdsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewState()
        bindAdCategories()
        viewModel.bindDataSources()
        
        viewModel.refreshDatas()
        
        navigationItem.title = "LBC"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupConstraints()
    }
    
    // MARK: - Methods

    private func bindViewState() {
        viewModel.$viewState
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.apply(state: $0)
            }
            .store(in: &cancellables)
    }
    
    private func bindAdCategories() {
        viewModel.$adCategories
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.navigationItem.rightBarButtonItem = self?.createFilterBarButtonItem()
            }
            .store(in: &cancellables)
    }

    func apply(state: AdsViewModel.ViewState) {
        switch state {
        case .loading:
            collectionView.backgroundView = UIActivityIndicatorView(style: .medium).configure { $0.startAnimating() }
        case .error:
            print("Display retry view")
        case let .loaded(content):
            switch content {
            case let .default(snapshot):
                collectionView.backgroundView = nil
                dataSource.apply(snapshot)
                
            case let .filtered(snapshot):
                collectionView.backgroundView = snapshot.numberOfItems > 0 ? nil : nil // No result view
                dataSource.apply(snapshot)
            }
        }
    }
    
    private func createFilterBarButtonItem() -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(image: .init(systemName: "line.3.horizontal.decrease.circle"),
                                            style: .plain,
                                            target: nil,
                                            action: nil)
        
        barButtonItem.menu = .init(title: "",
                                   children: viewModel.adCategories.map { category in
            UIAction(title: category.name) { [weak self] _ in self?.didTapFilter(by: category) } })
        
        return barButtonItem
    }
    
    private func didTapFilter(by category: AdCategory) {
        viewModel.didTapFilter(by: category)
    }

    private func setupConstraints() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }

    func createDataSource() -> UICollectionViewDiffableDataSource<AdsSection, Ad> {
        let cellRegistration = UICollectionView.CellRegistration
        <AdCollectionViewCell, Ad> { [weak self] cell, _, newsItem in
            guard let self else { return }
            cell.fillUI(with: newsItem,
                        of: newsItem.category(in: self.viewModel.adCategories))
        }

        return UICollectionViewDiffableDataSource<AdsSection, Ad>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Ad) -> UICollectionViewCell? in
            // Return the cell.
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: item)
        }
    }

    func createLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(200))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 2)
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                        leading: 10,
                                                        bottom: 10,
                                                        trailing: 10)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
