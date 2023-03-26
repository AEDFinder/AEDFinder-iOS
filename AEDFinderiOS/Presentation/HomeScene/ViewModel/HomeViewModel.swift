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
        let didTappedRadiusButton: Observable<RadiusMode> //default: 50m
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
                
        let fetchAEDLocation = input.didTappedRadiusButton.withLatestFrom(didgotCurrnetLocation.asObservable()) { radius, location  in
            return (radius, location)
        }
            .map { $0 }
            .flatMap {
                self.homeUseCase.fetchHomeInfo($0.1, radius: $0.0.radius)
            }
            .map { result in
                switch result {
                case .success(let AEDs):
                    return AEDs
                case .failure(let error):
                    errorValue.accept(error)
                }
                return []
            }
          
//        let fetchAEDLocation = didgotCurrnetLocation.asObservable()
//            .debug()
//            .flatMap { self.homeUseCase.fetchHomeInfo($0, radius: 1000)}
//        .compactMap { result in
//            switch result {
//            case .success(let AEDs):
//                return AEDs
//            case .failure(let error):
//                errorValue.accept(error)
//            }
//            return []
//        }
        
//        let fetchAEDLocation = didgotCurrnetLocation.asObservable()
//        .flatMap(homeUseCase.fetchHomeInfo(_:))
//        .compactMap { result in
//            switch result {
//            case .success(let AEDs):
//                return AEDs
//            case .failure(let error):
//                errorValue.accept(error)
//            }
//            return []
//        }

        return Output(
            showCurrentLocation: fetchCurrentLocation
                .asDriver(onErrorDriveWith: .empty()),
            showArroundAEDLocation: fetchAEDLocation
                .asDriver(onErrorJustReturn: []),
            showErrorValue: errorValue
        )
    }
}
