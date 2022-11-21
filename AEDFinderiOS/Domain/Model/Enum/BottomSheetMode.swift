//
//  BottomSheetMode.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/21.
//

import UIKit

enum BottomSheetMode {
    case tip
    case full
}

enum Const {
    static let duration = 0.5
    static let cornerRadius = 12.0
    static let barViewTopSpacing = 5.0
    static let barViewSize = CGSize(
        width: UIScreen.main.bounds.width * 0.2,
        height: 5.0)
    static let bottomSheetRatio: (BottomSheetMode) -> Double = { mode in
        switch mode {
        case .tip:
            return 0.9
        case .full:
            return 0.5
        }
    }
    static let bottomSheetYPosition: (BottomSheetMode) -> Double = { mode in
        Self.bottomSheetRatio(mode) * UIScreen.main.bounds.height
    }
}
