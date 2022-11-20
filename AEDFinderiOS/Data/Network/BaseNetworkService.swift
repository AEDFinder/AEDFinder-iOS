//
//  BaseNetworkService.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import Moya
import RxSwift

class BaseNetworkService<EndPoint: TargetType>: Networkable {
    typealias Target = EndPoint
    
    private let provider = makeProvider()

    func request(_ endPoint: EndPoint) -> Single<Response> {
        return self.provider.rx.request(endPoint)
            
    }
}
