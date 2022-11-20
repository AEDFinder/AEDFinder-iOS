//
//  HomeViewModel.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private weak var coordinator: HomeCoordinator?
    private let homeUseCase: HomeUseCase
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func transform(from input: Input) -> Output {
        
        return Output()
    }
}
