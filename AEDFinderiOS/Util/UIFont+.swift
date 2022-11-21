//
//  UIFont+.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/21.
//

import UIKit

extension UIFont {
    public enum AppleFont {
        case bold
        case semibold
        case regular
        case light
        case medium
        
        var name: String {
            switch self {
            case .bold:
                return "AppleSDGothicNeo-Bold"
            case .semibold:
                return "AppleSDGothicNeo-SemiBold"
            case .regular:
                return "AppleSDGothicNeo-Regular"
            case .light:
                return "AppleSDGothicNeo-Light"
            case .medium:
                return "AppleSDGothicNeo-Medium"
            }
        }
    }
    
    static func SD_Gothic(_ type: AppleFont, size: CGFloat) -> UIFont {
        return UIFont(name: type.name, size: size)!
    }
}
