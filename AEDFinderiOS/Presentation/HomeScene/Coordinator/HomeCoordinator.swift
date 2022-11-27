//
//  HomeCoordinator.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import UIKit

protocol HomeCoordinator: Coordinator {
    func showBottomSheet()
}

final class DefaultHomeCoordinator: HomeCoordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let repository = DefaultHomeRepository(homeNetworkService: HomeNetworkService())
        let useCase = DefaultHomeUseCase(homeRepository: repository)
        let viewModel = HomeViewModel(homeUseCase: useCase)
        let vc = HomeViewController.create(with: viewModel, self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showBottomSheet() {
        
    }
    
}
