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
    
    func fetchHomeInfo(_ location: CLLocation, radius: Int) -> Observable<Result<[HomeInfoResponseDTO], LocationError>> {
        return self.request(.fetchHomeInfo(currentLocation: HomeInfoRequestDTO(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )))
            .filter(statusCode: 200)
            .map([HomeInfoResponseDTO].self)
            .map { Result.success($0) }
            .debug()
            .catch { _ in .just(Result.failure(LocationError.unableToFindAED)) }
            .asObservable()
    }
    
    func getCurrentLocation() -> Observable<Result<CLLocation, LocationError>> {
        LocationPermissionManager.shared.requestLocation()
            .bind { _ in }
            .disposed(by: disposeBag)

        return LocationPermissionManager.shared.locationSubject
            .compactMap { Result.success($0 ?? CLLocation()) }
            .catch { _ in
                .just(Result.failure(LocationError.unableToDetermineLocation))
            }
            .asObservable()
        }
}
