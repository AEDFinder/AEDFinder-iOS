//
//  RadiusMode.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/29.
//

import Foundation

public enum RadiusMode {
    case fifty
    case hundred
    case twoHundred
    
    var radius: Int {
        switch self {
        case .fifty:
            return 50
        case .hundred:
            return 100
        case .twoHundred:
            return 500
        }
    }
}
