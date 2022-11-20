//
//  HomeAPI.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import Moya

enum HomeAPI {
    case fetchHomeInfo
}

extension HomeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "url")!
    }
    
    var path: String {
        switch self {
        case .fetchHomeInfo:
            return "home Path"
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
        case .fetchHomeInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
