//
//  Rx+UIButton.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/29.
//

import UIKit
import RxSwift

extension Reactive where Base: UIButton {    
    public var fiftyRadius: Observable<RadiusMode> {
        return base.rx.tap
            .map { _ -> RadiusMode in
                return RadiusMode.fifty
            }
    }
    
    public var hundredRadius: Observable<RadiusMode> {
        return base.rx.tap
            .map { _ -> RadiusMode in
                return RadiusMode.hundred
            }
    }
    
    public var twoHundredRadius: Observable<RadiusMode> {
        return base.rx.tap
            .map { _ -> RadiusMode in
                return RadiusMode.twoHundred
            }
    }
}
