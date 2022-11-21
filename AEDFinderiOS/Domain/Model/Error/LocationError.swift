//
//  LocationError.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation

enum LocationError: Error {
    case unauthorized
    case unableToDetermineLocation
    
    var message: String {
        switch self {
        case .unauthorized:
            return "위치 추적에 동희하지 않아 \n현재 위치를 가져올 수 없습니다."
        case .unableToDetermineLocation:
            return "현재 위치를 가져올 수 없습니다. 관리자에게 문의해주세요."
        }
    }
}
