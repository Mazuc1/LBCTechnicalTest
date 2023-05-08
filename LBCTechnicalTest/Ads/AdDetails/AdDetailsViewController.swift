//
//  AdDetailsViewController.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 08/05/2023.
//

import UIKit

final class AdDetailsViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: AdDetailsViewModel
    private let imageHeight: CGFloat = 300
    private let isUrgentImageSize: CGSize = .init(width: 20, height: 20)

    // MARK: - UI

    private let scrollView: UIScrollView = .init().configure {
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LBCColor.lightGray.color
    }

    private let contentView: UIView = .init().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LBCColor.lightGray.color
    }

    private let imageViewAd: AsyncImageView = .init(frame: .zero).configure {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let labelAdTitle: UILabel = .init().configure {
        $0.textColor = LBCColor.ink.color
        $0.font = LBCFont.demiBoldM.font
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
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

    private let labelAdPrice: UILabel = .init().configure {
        $0.textColor = LBCColor.inkLight.color
        $0.font = LBCFont.mediumL.font
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let labelAdDescription: UILabel = .init().configure {
        $0.textColor = LBCColor.ink.color
        $0.font = LBCFont.mediumXS.font
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let labelAdDate: UILabel = .init().configure {
        $0.textColor = LBCColor.inkLight.color
        $0.font = LBCFont.mediumXS.font
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let labelAdSiret: UILabel = .init().configure {
        $0.textColor = LBCColor.inkLight.color
        $0.font = LBCFont.mediumXS.font
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let imageViewIsUrgent: UIImageView = .init().configure {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Init

    required init(viewModel: AdDetailsViewModel) {
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
        view.backgroundColor = LBCColor.lightGray.color
        
        setupScrollView()
        setupView()
        fillUI()
    }

    // MARK: - Methods

    private func setupScrollView() {
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])

        scrollView.addSubview(contentView)
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            heightConstraint,
        ])
    }

    private func setupView() {
        contentView.addSubview(imageViewAd)
        contentView.addSubview(labelAdTitle)
        contentView.addSubview(labelAdCategory)
        contentView.addSubview(labelAdPrice)
        contentView.addSubview(labelAdDescription)
        contentView.addSubview(labelAdDate)

        NSLayoutConstraint.activate([
            imageViewAd.heightAnchor.constraint(equalToConstant: imageHeight),
            imageViewAd.widthAnchor.constraint(equalToConstant: view.frame.width),

            imageViewAd.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewAd.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewAd.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            labelAdTitle.topAnchor.constraint(equalTo: imageViewAd.bottomAnchor, constant: DS.defaultSpacing(factor: 2)),
            labelAdTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DS.defaultSpacing),
            contentView.trailingAnchor.constraint(equalTo: labelAdTitle.trailingAnchor, constant: DS.defaultSpacing),

            labelAdCategory.topAnchor.constraint(equalTo: labelAdTitle.bottomAnchor, constant: DS.defaultSpacing),
            labelAdCategory.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DS.defaultSpacing),

            labelAdPrice.topAnchor.constraint(equalTo: labelAdCategory.bottomAnchor, constant: DS.defaultSpacing),
            labelAdPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DS.defaultSpacing),

            labelAdDescription.topAnchor.constraint(equalTo: labelAdPrice.bottomAnchor, constant: DS.defaultSpacing(factor: 2)),
            labelAdDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DS.defaultSpacing),
            contentView.trailingAnchor.constraint(equalTo: labelAdDescription.trailingAnchor, constant: DS.defaultSpacing),

            labelAdDate.topAnchor.constraint(equalTo: labelAdDescription.bottomAnchor, constant: DS.defaultSpacing(factor: 2)),
            contentView.trailingAnchor.constraint(equalTo: labelAdDate.trailingAnchor, constant: DS.defaultSpacing),
        ])

        if viewModel.ad.siret == nil {
            contentView.bottomAnchor.constraint(equalTo: labelAdDate.bottomAnchor, constant: DS.defaultSpacing).isActive = true
        }
    }

    private func addLabelSiret(siret: String) {
        labelAdSiret.text = "Siret: \(siret)"
        contentView.addSubview(labelAdSiret)

        NSLayoutConstraint.activate([
            labelAdSiret.topAnchor.constraint(equalTo: labelAdDate.bottomAnchor, constant: DS.defaultSpacing),
            contentView.trailingAnchor.constraint(equalTo: labelAdSiret.trailingAnchor, constant: DS.defaultSpacing),
            contentView.bottomAnchor.constraint(equalTo: labelAdSiret.bottomAnchor, constant: DS.defaultSpacing),
        ])
    }

    private func addUrgentImageView() {
        imageViewAd.addSubview(imageViewIsUrgent)

        NSLayoutConstraint.activate([
            imageViewIsUrgent.widthAnchor.constraint(equalToConstant: isUrgentImageSize.width),
            imageViewIsUrgent.heightAnchor.constraint(equalToConstant: isUrgentImageSize.height),
            imageViewAd.bottomAnchor.constraint(equalTo: imageViewIsUrgent.bottomAnchor, constant: DS.defaultSpacing),
            imageViewAd.trailingAnchor.constraint(equalTo: imageViewIsUrgent.trailingAnchor, constant: DS.defaultSpacing),
        ])
    }

    private func fillUI() {
        if let url = viewModel.ad.imagesURL.thumb {
            imageViewAd.loadImage(from: url, completion: { _ in })
        }

        labelAdTitle.text = viewModel.ad.title

        labelAdCategory.text = viewModel.adCategory.name
        labelAdCategory.textColor = viewModel.adCategory.color
        labelAdCategory.backgroundColor = viewModel.adCategory.color.withAlphaComponent(0.2)

        labelAdPrice.text = "\(viewModel.ad.price)€"
        labelAdDescription.text = viewModel.ad.description

        labelAdDate.text = "Posté le \(viewModel.formattedAdDate())"

        if let siret = viewModel.ad.siret {
            addLabelSiret(siret: siret)
        }

        if viewModel.ad.isUrgent {
            addUrgentImageView()
        }
    }
}
