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

    // MARK: - UI

    private let imageViewAd: UIImageView = .init().configure {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .brown
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let labelAdTitle: UILabel = .init().configure {
        $0.textColor = .black
        $0.numberOfLines = 2
    }

    private let labelAdPrice: UILabel = .init().configure {
        $0.textColor = .black
    }

    private let labelAdCategory: UILabel = .init().configure {
        $0.textColor = .black
    }

    private let imageViewUrgent: UIImageView = .init().configure {
        $0.contentMode = .scaleAspectFit
    }

    private let stackViewAdInformations: UIStackView = .init().configure {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.isLayoutMarginsRelativeArrangement = true
        let edge = DS.defaultSpacing(factor: 0.5)
        $0.layoutMargins = .init(top: edge,
                                 left: edge,
                                 bottom: edge,
                                 right: edge)
    }

    private let stackViewContent = UIStackView().configure {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.backgroundColor = .white
        $0.layer.cornerRadius = DS.defaultRadius
        $0.clipsToBounds = true
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

    func fillUI(with ad: Ad) {
        labelAdTitle.text = ad.title
        labelAdCategory.text = ad.category.name
        labelAdPrice.text = "\(ad.price)"

        setupView()
    }

    private func setupView() {
        stackViewAdInformations.addArrangedSubview(labelAdTitle)
        stackViewAdInformations.addArrangedSubview(UIStackView().configure {
            $0.axis = .horizontal
            $0.alignment = .leading
            $0.distribution = .equalSpacing
            $0.addArrangedSubviews([labelAdCategory, labelAdPrice])
        })

        stackViewContent.addArrangedSubviews([imageViewAd, stackViewAdInformations])

        contentView.addSubview(stackViewContent) // set constraint strech in view

        NSLayoutConstraint.activate([
            imageViewAd.widthAnchor.constraint(equalToConstant: contentView.frame.width),

            stackViewContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackViewContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])

        contentView.layer.shadowColor = UIColor(cgColor: .init(red: 0, green: 0, blue: 0, alpha: 1)).cgColor
        contentView.layer.shadowRadius = DS.defaultRadius
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .init(width: 2, height: 3)

        /// Fix shadow performance
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
    }
}
