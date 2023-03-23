//
//  HomeAPI.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import Moya

enum HomeAPI {
    case fetchHomeInfo(currentLocation: HomeInfoRequestDTO)
}

extension HomeAPI: TargetType {
    var baseURL: URL {
        return APP.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchHomeInfo:
            return "/aed/finder"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchHomeInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchHomeInfo(let reqData):
            let param = reqData.toDictionary() ?? [:]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
