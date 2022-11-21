//
//  HomeRepository.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import RxSwift
import CoreLocation

protocol HomeRepository: AnyObject {
    func fetchHomeInfo() -> Observable<Result<HomeInfo, Error>>
    
    func getCurrentLocation() -> Observable<Result<CLLocation, LocationError>>
}
