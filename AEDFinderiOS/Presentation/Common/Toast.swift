//
//  Toast.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2023/03/27.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import Then

final class Toast: UIView {
    public struct Input {
        let title: String
        let colors: ColorSet
        let confirmButtonTitle: String?
        let onTapConfirmButton: (() -> Void)?
        
        init(title: String, colors: ColorSet, confirmButtonTitle: String? = nil, onTapConfirmButton: (() -> Void)? = nil) {
            self.title = title
            self.colors = colors
            self.confirmButtonTitle = confirmButtonTitle
            self.onTapConfirmButton = onTapConfirmButton
        }
    }
    
    override var intrinsicContentSize: CGSize {
        body.flex.intrinsicSize
    }
    
    private let input: Input
    
    private let body = UIView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: init
    init(_ input: Input) {
        self.input = input
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        body.pin.all()
        body.flex.layout(mode: .adjustHeight)
    }
    
    private func setupLayout() {
        addSubview(body)
        
        body.flex.direction(.row).alignItems(.center).justifyContent(.spaceBetween).define { flex in
            flex.direction(.row).alignItems(.center).define { flex in
                flex.addItem(UILabel(text: input.title, textColor: input.colors.contentColor, font: UIFont(), numberOfLines: 0).then {
                    $0.lineBreakMode = .byCharWrapping
                })
                .shrink(1)
                .define { flex in
                    flex.marginRight(12)
                }
            }
            .marginVertical(8)
            
            if let confirmButtonTitle = input.confirmButtonTitle {
                flex.addItem(UILabel(text: confirmButtonTitle, textColor: .orange, font: UIFont(), numberOfLines: 0))
                    .margin(12)
                    .onTap(disposeBag: disposeBag, throttle: .milliseconds(300)) { [weak self] in
                        //TODO: Toast 버튼 액션
                    }
            }
        }
        .cornerRadius(12)
        .padding(8)
        .backgroundColor(input.colors.backgroundColor)
        
        body.layer.masksToBounds = false
        body.layer.shadowColor = UIColor.black.cgColor
    }
        

    
}

extension Toast {
    public struct ColorSet {
        let backgroundColor: UIColor
        let contentColor: UIColor
        
        public static let blackColorSet = ColorSet(backgroundColor: .gray.withAlphaComponent(0.8), contentColor: .white)
        public static let whiteColorSet = ColorSet(backgroundColor: .white, contentColor: .black)
    }
}
