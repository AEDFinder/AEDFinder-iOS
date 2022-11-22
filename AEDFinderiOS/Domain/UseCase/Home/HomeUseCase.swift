//
//  HomeUseCase.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import RxSwift
import CoreLocation

protocol HomeUseCase: AnyObject {
    func fetchHomeInfo(_ location: CLLocation) -> Observable<Result<[HomeInfo], LocationError>>
    func getCurrentLocation() -> Observable<Result<CLLocation, LocationError>>
}

final class DefaultHomeUseCase: HomeUseCase {
    private let homeRepository: HomeRepository
    
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }
    
    func fetchHomeInfo(_ location: CLLocation) -> Observable<Result<[HomeInfo], LocationError>> {
        return self.homeRepository.fetchHomeInfo(location)
    }
    
    func getCurrentLocation() -> Observable<Result<CLLocation, LocationError>> {
        return self.homeRepository.getCurrentLocation()
    }
}
