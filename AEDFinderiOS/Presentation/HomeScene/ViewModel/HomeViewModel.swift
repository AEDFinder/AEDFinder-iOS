//
//  HomeViewModel.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

final class HomeViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let showCurrentLocation: Driver<CLLocation>
    }
    
    private weak var coordinator: HomeCoordinator?
    private let homeUseCase: HomeUseCase
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func transform(from input: Input) -> Output {
        let fetchCurrentLocation = input.viewWillAppear
            .debug()
            .flatMap(homeUseCase.getCurrentLocation)
            .compactMap { result -> CLLocation in
                guard case let .success(location) = result else { return CLLocation() }
                return location
            }
            
        
        return Output(
            showCurrentLocation: fetchCurrentLocation
                .asDriver(onErrorDriveWith: .empty())
                
        )
    }
}
