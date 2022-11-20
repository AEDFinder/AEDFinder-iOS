//
//  HomeViewController.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import UIKit

final class HomeViewController: BaseViewController {
    
    weak var coordinator: HomeCoordinator?
    private var viewModel: HomeViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    static func create(
        with viewModel: HomeViewModel,
        _ coordinator: HomeCoordinator
    ) -> HomeViewController {
        let vc = HomeViewController()
        vc.viewModel = viewModel
        vc.coordinator = coordinator
        return vc
    }
}
