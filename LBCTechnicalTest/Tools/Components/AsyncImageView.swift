//
//  AsyncImageView.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 04/05/2023.
//

import UIKit

final class AsyncImageView: UIImageView {
    // MARK: - UI

    private let activityIndicator: UIActivityIndicatorView = .init().configure {
        $0.style = .medium
        $0.color = LBCColor.inkLight.color
        $0.hidesWhenStopped = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        activityIndicator.startAnimating()

        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)

            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.image = image
                completion(image)
            }
        }
    }
}
