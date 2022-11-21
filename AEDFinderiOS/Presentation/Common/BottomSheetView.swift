//
//  BottomSheetView.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/21.
//

import Foundation
import UIKit

class BottomSheetView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        return hitView == self ? nil : hitView
    }
}
