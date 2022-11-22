//
//  LocationPermissionManager.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/22.
//

import RxSwift
import RxCocoa
import RxCoreLocation
import CoreLocation

class LocationPermissionManager {
    static let shared = LocationPermissionManager()
    private let disposeBag = DisposeBag()
    
    let locationSubject = BehaviorSubject<CLLocation?>(value: nil)
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        return manager
    }()
    
    private init() {
        locationManager.rx.didUpdateLocations
            .compactMap(\.locations.last?)
            .bind(onNext: self.locationSubject.onNext(_:))
            .disposed(by: disposeBag)
        locationManager.stopUpdatingLocation() //이미 권한을 허용한 경우의 케이스
    }
    
    func requestLocation() -> Observable<CLAuthorizationStatus> {
        return Observable<CLAuthorizationStatus>
            .deferred { [weak self] in
                guard let self = self else { return .empty() }
                self.locationManager.requestWhenInUseAuthorization()
                return self.locationManager.rx.didChangeAuthorization
                    .map { $1 }
                    .filter { $0 != .notDetermined }
                    .do(onNext: { _ in self.locationManager.startUpdatingLocation()
                        self.locationManager.stopUpdatingLocation()
                    })
                    .take(1)
            }
    }
}
