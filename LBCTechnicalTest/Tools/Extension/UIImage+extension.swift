//
//  UIImage+extension.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 07/05/2023.
//

import UIKit

extension UIImage {
    class func systemImage(_ name: String, weight: UIImage.SymbolWeight, size: CGFloat) -> UIImage {
        let imageWeightConfiguration = UIImage.SymbolConfiguration(weight: weight)
        let imageSizeConfiguration = UIImage.SymbolConfiguration(pointSize: size)

        let imageFinalConfiguration = imageWeightConfiguration.applying(imageSizeConfiguration)

        return UIImage(systemName: name, withConfiguration: imageFinalConfiguration) ?? UIImage()
    }
}


