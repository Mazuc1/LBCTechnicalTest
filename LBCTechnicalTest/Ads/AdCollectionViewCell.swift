//
//  AdCollectionViewCell.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

final class AdCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    static let reuseIdentifier: String = "AdCollectionViewCell"
    private let imageHeight: CGFloat = 140
    private let isUrgentImageSize: CGSize = .init(width: 20, height: 20)

    // MARK: - UI

    private let imageViewAd: AsyncImageView = .init(frame: .zero).configure {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let labelAdTitle: UILabel = .init().configure {
        $0.textColor = LBCColor.ink.color
        $0.font = LBCFont.demiBoldS.font
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let labelAdPrice: UILabel = .init().configure {
        $0.textColor = LBCColor.inkLight.color
        $0.font = LBCFont.mediumS.font
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private let labelAdCategory: PaddingLabel = .init(topInset: DS.defaultSpacing(factor: 0.5),
                                                      bottomInset: DS.defaultSpacing(factor: 0.5),
                                                      leftInset: DS.defaultSpacing(factor: 0.5),
                                                      rightInset: DS.defaultSpacing(factor: 0.5)).configure {
        $0.font = LBCFont.mediumXS.font
        $0.layer.cornerRadius = DS.defaultRadius
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let imageViewUrgent: UIImageView = .init().configure {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let container: UIView = .init().configure {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func prepareForReuse() {
        imageViewAd.image = nil
        super.prepareForReuse()
    }

    func fillUI(with ad: Ad, of category: AdCategory) {
        labelAdTitle.text = ad.title
        let adPriceText = ad.price.isInteger ? "\(Int(ad.price))€" : "\(ad.price)€"
        labelAdPrice.text = adPriceText

        labelAdCategory.text = category.name
        labelAdCategory.textColor = category.color
        labelAdCategory.backgroundColor = category.color.withAlphaComponent(0.2)

        let adID = NSNumber(integerLiteral: ad.id)

        if let cachedImage = AdsViewController.adCellImagesCache.object(forKey: adID) {
            imageViewAd.image = cachedImage
        } else {
            guard let url = ad.imagesURL.thumb else { return }
            imageViewAd.loadImage(from: url) { image in
                guard let image else { return }
                AdsViewController.adCellImagesCache.setObject(image, forKey: adID)
            }
        }

        setupView()

        if ad.isUrgent { addImageViewUrgent() } else {
            imageViewUrgent.removeFromSuperview()
        }
    }

    private func setupView() {
        contentView.addSubview(container)
        contentView.addSubview(imageViewAd)
        contentView.addSubview(labelAdTitle)
        contentView.addSubview(labelAdCategory)
        contentView.addSubview(labelAdPrice)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageViewAd.heightAnchor.constraint(equalToConstant: imageHeight),
            imageViewAd.widthAnchor.constraint(equalToConstant: contentView.frame.width),

            imageViewAd.topAnchor.constraint(equalTo: container.topAnchor),
            imageViewAd.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageViewAd.trailingAnchor.constraint(equalTo: container.trailingAnchor),

            labelAdTitle.topAnchor.constraint(equalTo: imageViewAd.bottomAnchor, constant: DS.defaultSpacing),
            labelAdTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: DS.defaultSpacing),
            container.trailingAnchor.constraint(equalTo: labelAdTitle.trailingAnchor, constant: DS.defaultSpacing),

            labelAdCategory.topAnchor.constraint(equalTo: labelAdTitle.bottomAnchor, constant: DS.defaultSpacing(factor: 0.5)),
            labelAdCategory.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: DS.defaultSpacing),

            labelAdPrice.topAnchor.constraint(equalTo: labelAdTitle.bottomAnchor, constant: DS.defaultSpacing(factor: 0.5)),
            labelAdPrice.centerYAnchor.constraint(equalTo: labelAdCategory.centerYAnchor),
            container.trailingAnchor.constraint(equalTo: labelAdPrice.trailingAnchor, constant: DS.defaultSpacing),
            container.bottomAnchor.constraint(equalTo: labelAdPrice.bottomAnchor, constant: DS.defaultSpacing),

            labelAdPrice.leadingAnchor.constraint(greaterThanOrEqualTo: labelAdCategory.trailingAnchor, constant: DS.defaultSpacing),
        ])

        contentView.layer.cornerRadius = DS.defaultRadius
        contentView.clipsToBounds = true
    }

    private func addImageViewUrgent() {
        imageViewAd.addSubview(imageViewUrgent)

        NSLayoutConstraint.activate([
            imageViewUrgent.widthAnchor.constraint(equalToConstant: isUrgentImageSize.width),
            imageViewUrgent.heightAnchor.constraint(equalToConstant: isUrgentImageSize.height),
            imageViewAd.bottomAnchor.constraint(equalTo: imageViewUrgent.bottomAnchor, constant: DS.defaultSpacing),
            imageViewAd.trailingAnchor.constraint(equalTo: imageViewUrgent.trailingAnchor, constant: DS.defaultSpacing),
        ])
    }
}
