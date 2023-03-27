//
//  UILabel+.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2023/03/27.
//

import UIKit

extension UILabel {
    convenience init(
        text: String,
        textColor: UIColor,
        font: UIFont,
        textAlignment: NSTextAlignment = .center,
        numberOfLines: Int = 1
    ) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
