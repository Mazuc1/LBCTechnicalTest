//
//  AdsViewController.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import Combine
import UIKit

enum AdsSection {
    case main
}

final class AdsViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: AdsViewModel
    private let layoutSizeHeight: CGFloat = 200

    static let adCellImagesCache: NSCache<NSNumber, UIImage> = {
        let cache = NSCache<NSNumber, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 50 * 1024 * 1024 // 50MB
        return cache
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<AdsSection, Ad> = createDataSource()

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - UI

    lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: createLayout()).configure { [weak self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.backgroundColor = LBCColor.lightGray.color
    }

    private lazy var buttonCancelAdsFilterHeightConstraint: NSLayoutConstraint = .init(item: buttonCancelAdsFilter,
                                                                                       attribute: .height,
                                                                                       relatedBy: .equal,
                                                                                       toItem: nil,
                                                                                       attribute: .notAnAttribute,
                                                                                       multiplier: 1,
                                                                                       constant: 0)

    lazy var buttonCancelAdsFilter: UIButton = .init().configure { [weak self] in
        guard let self else { return }

        $0.titleLabel?.font = LBCFont.mediumM.font
        $0.setTitleColor(.black, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black.withAlphaComponent(0.2)
        $0.layer.cornerRadius = DS.defaultRadius
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(didTapCancelFilteredAds), for: .touchUpInside)

        $0.setImage(UIImage.systemImage("xmark", weight: .medium, size: 13), for: .normal)
        $0.isHidden = true

        let verticalInset = DS.defaultSpacing(factor: 0.5)
        let horizontalInset = DS.defaultSpacing

        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: verticalInset,
                                                                  leading: horizontalInset,
                                                                  bottom: verticalInset,
                                                                  trailing: horizontalInset)
            $0.configuration = configuration
        } else {
            $0.contentEdgeInsets = .init(top: verticalInset,
                                         left: horizontalInset,
                                         bottom: verticalInset,
                                         right: horizontalInset)
        }
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

        view.backgroundColor = LBCColor.lightGray.color
        navigationItem.title = "Annonces"

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
            collectionView.backgroundView = Self.ErrorView(action: { [weak self] in self?.viewModel.refreshDatas() })
        case let .loaded((snapshot, category)):
            collectionView.backgroundView = snapshot.numberOfItems > 0 ? nil : Self.NoResultView(adCategoryName: category?.name ?? "")
            dataSource.apply(snapshot)
            updateUIOfCancelCategoryButton(for: category)
        }
    }

    private func updateUIOfCancelCategoryButton(for category: AdCategory?) {
        if let category {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.buttonCancelAdsFilter.isHidden = false
                self?.buttonCancelAdsFilterHeightConstraint.constant = 30
            }

            buttonCancelAdsFilter.setTitle(category.name,
                                           for: .normal)
            buttonCancelAdsFilter.backgroundColor = category.color.withAlphaComponent(0.2)
        } else {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.buttonCancelAdsFilter.isHidden = true
                self?.buttonCancelAdsFilterHeightConstraint.constant = 0
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
                                       UIAction(title: category.name) { [weak self] _ in self?.didTapFilter(by: category) }
                                   })

        return barButtonItem
    }

    private func didTapFilter(by category: AdCategory) {
        viewModel.didTapFilter(by: category)
    }

    @objc private func didTapCancelFilteredAds() {
        viewModel.didTapCancelFilteredAds()
    }

    private func setupConstraints() {
        view.addSubview(buttonCancelAdsFilter)

        NSLayoutConstraint.activate([
            buttonCancelAdsFilter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DS.defaultSpacing(factor: 2)),
            buttonCancelAdsFilter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])

        buttonCancelAdsFilter.addConstraint(buttonCancelAdsFilterHeightConstraint)

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: buttonCancelAdsFilter.bottomAnchor, constant: DS.defaultSpacing),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func createDataSource() -> UICollectionViewDiffableDataSource<AdsSection, Ad> {
        let cellRegistration = UICollectionView.CellRegistration
        <AdCollectionViewCell, Ad> { [weak self] cell, _, newsItem in
            guard let self else { return }
            cell.fillUI(with: newsItem,
                        of: newsItem.category(in: self.viewModel.adCategories))
        }

        return UICollectionViewDiffableDataSource<AdsSection, Ad>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Ad) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: item)
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(layoutSizeHeight))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(layoutSizeHeight))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 2)
        group.interItemSpacing = .fixed(DS.defaultSpacing(factor: 1.5))

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: DS.defaultSpacing,
                                                        leading: DS.defaultSpacing,
                                                        bottom: DS.defaultSpacing,
                                                        trailing: DS.defaultSpacing)
        section.interGroupSpacing = DS.defaultSpacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - UICollectionViewDelegate

extension AdsViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.didTap(ad: item)
    }
}

// MARK: - NoResultView

extension AdsViewController {
    class NoResultView: UIView {
        private let adCategoryName: String

        init(adCategoryName: String) {
            self.adCategoryName = adCategoryName
            super.init(frame: .zero)
            setup()
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setup() {
            createNoResultView().stretchInView(parentView: self)
        }

        private func createNoResultView() -> UIView {
            UIStackView(arrangedSubviews: [
                UILabel().configure(block: {
                    let sentence = "Aucun résultat pour \(adCategoryName)"
                    let attributedString = NSMutableAttributedString(string: sentence, attributes: [NSAttributedString.Key.font: LBCFont.mediumS.font])
                    let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: LBCFont.demiBoldS.font]
                    let range = (sentence as NSString).range(of: adCategoryName)
                    attributedString.addAttributes(boldFontAttribute, range: range)

                    $0.attributedText = attributedString
                    $0.textAlignment = .center
                }),
                UIView(),
            ]).configure {
                $0.axis = .vertical
                $0.isLayoutMarginsRelativeArrangement = true
                let spacing = DS.defaultSpacing(factor: 2)
                $0.layoutMargins = .init(top: spacing,
                                         left: spacing,
                                         bottom: spacing,
                                         right: spacing)
            }
        }
    }
}

// MARK: - ErrorView

extension AdsViewController {
    class ErrorView: UIView {
        private let action: () -> Void

        private lazy var buttonRetry: UIButton = .init().configure { [weak self] in
            guard let self else { return }

            $0.setTitle("Réessayer", for: .normal)
            $0.titleLabel?.font = LBCFont.mediumM.font
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .black.withAlphaComponent(0.2)
            $0.layer.cornerRadius = DS.defaultRadius
            $0.tintColor = .black
            $0.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)

            let verticalInset = DS.defaultSpacing(factor: 0.5)
            let horizontalInset = DS.defaultSpacing(factor: 2)

            if #available(iOS 15.0, *) {
                var configuration = UIButton.Configuration.plain()
                configuration.contentInsets = NSDirectionalEdgeInsets(top: verticalInset,
                                                                      leading: horizontalInset,
                                                                      bottom: verticalInset,
                                                                      trailing: horizontalInset)
                $0.configuration = configuration
            } else {
                $0.contentEdgeInsets = .init(top: verticalInset,
                                             left: horizontalInset,
                                             bottom: verticalInset,
                                             right: horizontalInset)
            }
        }

        init(action: @escaping () -> Void) {
            self.action = action
            super.init(frame: .zero)
            setup()
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setup() {
            createErrorView().stretchInView(parentView: self)
        }

        private func createErrorView() -> UIView {
            UIStackView(arrangedSubviews: [
                UILabel().configure(block: {
                    $0.text = "Oups, une erreur est survenue."
                    $0.font = LBCFont.mediumS.font
                    $0.textAlignment = .center
                }),
                buttonRetry,
                UIView(),
            ]).configure {
                $0.axis = .vertical
                $0.spacing = DS.defaultSpacing(factor: 2)
                $0.isLayoutMarginsRelativeArrangement = true
                let spacing = DS.defaultSpacing(factor: 2)
                $0.layoutMargins = .init(top: spacing,
                                         left: spacing,
                                         bottom: spacing,
                                         right: spacing)
            }
        }

        @objc private func didTapRetry() {
            action()
        }
    }
}
