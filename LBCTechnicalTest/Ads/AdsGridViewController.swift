//
//  AdsGridViewController.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

final class AdsGridViewController: UIViewController {
    // MARK: - Properties

    static let adCellImagesCache: NSCache<NSNumber, UIImage> = {
        let cache = NSCache<NSNumber, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 50 * 1024 * 1024 // 50MB
        return cache
    }()

    enum Section {
        case main
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Ad> = createDataSource()

    // MARK: - UI

    private lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: createLayout()).configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LBCColor.lightGray.color
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "LBC"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupConstraints()

        let newsItems = Ad.mockedDatas
        var snapshot = NSDiffableDataSourceSnapshot<Section, Ad>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newsItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func setupConstraints() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }

    func createDataSource() -> UICollectionViewDiffableDataSource<Section, Ad> {
        let cellRegistration = UICollectionView.CellRegistration
        <AdCollectionViewCell, Ad> { cell, _, newsItem in
            cell.fillUI(with: newsItem)
        }

        return UICollectionViewDiffableDataSource<Section, Ad>(collectionView: collectionView) {
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
