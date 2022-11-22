//
//  DefaultHomeRepository.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import RxSwift
import CoreLocation

final class DefaultHomeRepository: HomeRepository {
    private let homeNetworkService: HomeNetworkService
    
    init(homeNetworkService: HomeNetworkService) {
        self.homeNetworkService = homeNetworkService
    }
    
    func fetchHomeInfo(_ location: CLLocation) -> Observable<Result<[HomeInfo], LocationError>> {
        self.homeNetworkService.fetchHomeInfo(location)
            .map {
                result -> Result<[HomeInfo], LocationError> in
                switch result {
                case .success(let responseDTO):
                    return .success(responseDTO.map { $0.toDomain()} )
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
    
    func getCurrentLocation() -> Observable<Result<CLLocation, LocationError>> {
        self.homeNetworkService.getCurrentLocation()
    }
    
}
