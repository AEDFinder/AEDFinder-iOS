//
//  Flex+.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2023/03/27.
//

import UIKit
import RxSwift
import RxGesture
import FlexLayout

extension Flex {
    public func onTap(disposeBag: DisposeBag, throttle: RxTimeInterval, action: @escaping () -> Void) {
        guard let view = self.view else { return }
        view.rx.tapGesture()
            .when(.recognized)
            .throttle(throttle, latest: false, scheduler: MainScheduler.instance)
            .bind { _ in action() }
            .disposed(by: disposeBag)
    }
}
