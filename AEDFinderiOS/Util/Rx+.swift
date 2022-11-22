//
//  Rx+.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/21.
//

import RxSwift

extension Observable {
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
