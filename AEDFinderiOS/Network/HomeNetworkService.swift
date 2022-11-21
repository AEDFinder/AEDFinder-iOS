//
//  HomeNetworkService.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import RxSwift
import RxCoreLocation
import CoreLocation

final class HomeNetworkService: BaseNetworkService<HomeAPI> {
    
    private var locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    func fetchHomeInfo() -> Observable<Result<HomeInfoResponseDTO, Error>> {
        return self.request(.fetchHomeInfo)
            .filter(statusCode: 200)
            .map(HomeInfoResponseDTO.self)
            .map { Result.success($0) }
            .catch { .just(Result.failure($0)) }
            .asObservable()
    }
    
    func getCurrentLocation() -> Observable<Result<CLLocation, LocationError>> {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return locationManager.rx.location
            .map { Result.success($0!) }
            .catch { _ in .just(Result.failure(LocationError.unauthorized)) }
            .asObservable()
    }
}
