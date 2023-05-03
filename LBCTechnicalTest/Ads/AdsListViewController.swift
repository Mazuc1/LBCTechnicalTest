//
//  AdsListViewController.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

final class AdsListViewController: UICollectionViewController {
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Data source

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        12
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath).configure {
            $0.backgroundColor = .blue
        }
    }
}
