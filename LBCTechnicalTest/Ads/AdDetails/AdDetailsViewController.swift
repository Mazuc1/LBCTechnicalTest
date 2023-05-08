//
//  AdDetailsViewController.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 08/05/2023.
//

import UIKit

final class AdDetailsViewController: UIViewController {
    // MARK: - Properties
    
    let viewModel: AdDetailsViewModel
    
    // MARK: - Init
    
    required init(viewModel: AdDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
