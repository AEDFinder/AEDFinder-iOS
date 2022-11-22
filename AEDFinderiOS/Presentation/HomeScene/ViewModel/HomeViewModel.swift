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
        let showArroundAEDLocation: Driver<[HomeInfo]>
        let showErrorValue: PublishRelay<LocationError>
    }
    
    private weak var coordinator: HomeCoordinator?
    private let homeUseCase: HomeUseCase
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func transform(from input: Input) -> Output {
        let didgotCurrnetLocation = PublishSubject<CLLocation>()
        let errorValue = PublishRelay<LocationError>()
        
        let fetchCurrentLocation = input.viewWillAppear
            .flatMap(homeUseCase.getCurrentLocation)
            .compactMap { result in
                switch result {
                case .success(let location):
                    didgotCurrnetLocation.onNext(location)
                    return location
                case .failure(let error):
                    errorValue.accept(error)
                }
                return CLLocation()
            }
                
        let fetchAEDLocation = didgotCurrnetLocation.asObservable()
        .flatMap(homeUseCase.fetchHomeInfo(_:))
        .compactMap { result in
            switch result {
            case .success(let AEDs):
                return AEDs
            case .failure(let error):
                errorValue.accept(error)
            }
            return []
        }

        return Output(
            showCurrentLocation: fetchCurrentLocation
                .asDriver(onErrorDriveWith: .empty()),
            showArroundAEDLocation: fetchAEDLocation
                .asDriver(onErrorJustReturn: []),
            showErrorValue: errorValue
        )
    }
}
