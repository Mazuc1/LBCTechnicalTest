//
//  AdsCollectionViewController.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 03/05/2023.
//

import UIKit

final class AdsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties

    static let layout: UICollectionViewFlowLayout = .init().configure {
        $0.minimumLineSpacing = DS.defaultSpacing(factor: 2)
        $0.minimumInteritemSpacing = DS.defaultSpacing
        $0.scrollDirection = .vertical
        $0.sectionInset = .init(top: DS.defaultSpacing,
                                left: DS.defaultSpacing,
                                bottom: DS.defaultSpacing,
                                right: DS.defaultSpacing)
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "LBC"
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.backgroundColor = .white
        collectionView.register(AdCollectionViewCell.self,
                                forCellWithReuseIdentifier: AdCollectionViewCell.reuseIdentifier)
    }

    // MARK: - Data source

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        Ad.mockedDatas.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCollectionViewCell.reuseIdentifier, for: indexPath) as? AdCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.fillUI(with: Ad.mockedDatas[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize
    {
        let numberofItem: CGFloat = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let collectionViewWidth = collectionView.bounds.width

        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing

        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left

        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)

        return CGSize(width: width, height: width)
    }
}
