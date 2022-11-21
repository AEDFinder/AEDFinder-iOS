//
//  HomeBottomSheetView.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/21.
//

import UIKit
import SnapKit

class HomeBottomSheetView: BottomSheetView {
    let bottomSheetView: UIView = {
      let view = UIView()
      view.backgroundColor = .lightGray
      return view
    }()

    let barView: UIView = {
      let view = UIView()
      view.backgroundColor = .darkGray
      view.isUserInteractionEnabled = false
      return view
    }()
    
    var mode: BottomSheetMode = .tip {
       didSet {
         switch self.mode {
         case .tip:
             self.barViewColor = .darkGray.withAlphaComponent(0.5)
             self.bottomSheetColor = .lightGray.withAlphaComponent(0.5)
         case .full:
             self.barViewColor = .darkGray
             self.bottomSheetColor = .lightGray
         }
         self.updateConstraint(offset: Const.bottomSheetYPosition(self.mode))
       }
     }
    
    var bottomSheetColor: UIColor? {
      didSet { self.bottomSheetView.backgroundColor = self.bottomSheetColor }
    }
    var barViewColor: UIColor? {
      didSet { self.barView.backgroundColor = self.barViewColor }
    }
    
    // MARK: Initializer
      @available(*, unavailable)
      required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
      }
    
      override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        self.addGestureRecognizer(panGesture)
        
        self.bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.bottomSheetView.layer.cornerRadius = Const.cornerRadius
        self.bottomSheetView.clipsToBounds = true
        
        self.addSubview(self.bottomSheetView)
        self.bottomSheetView.addSubview(self.barView)
        
        self.bottomSheetView.snp.makeConstraints {
          $0.left.right.bottom.equalToSuperview()
          $0.top.equalTo(Const.bottomSheetYPosition(.tip))
        }
        self.barView.snp.makeConstraints {
          $0.centerX.equalToSuperview()
          $0.top.equalToSuperview().inset(Const.barViewTopSpacing)
          $0.size.equalTo(Const.barViewSize)
        }
      }
    
    // MARK: Methods
    @objc private func didPan(_ recognizer: UIPanGestureRecognizer) {
      let translationY = recognizer.translation(in: self).y
      let minY = self.bottomSheetView.frame.minY
      let offset = translationY + minY
      
      if Const.bottomSheetYPosition(.full)...Const.bottomSheetYPosition(.tip) ~= offset {
        self.updateConstraint(offset: offset)
        recognizer.setTranslation(.zero, in: self)
      }
      UIView.animate(
        withDuration: 0,
        delay: 0,
        options: .curveEaseOut,
        animations: self.layoutIfNeeded,
        completion: nil
      )
      
      guard recognizer.state == .ended else { return }
      UIView.animate(
        withDuration: Const.duration,
        delay: 0,
        options: .allowUserInteraction,
        animations: {
          // velocity를 이용하여 위로 스와이프인지, 아래로 스와이프인지 확인
          self.mode = recognizer.velocity(in: self).y >= 0 ? BottomSheetMode.tip : .full
        },
        completion: nil
      )
    }
    
    private func updateConstraint(offset: Double) {
      self.bottomSheetView.snp.remakeConstraints {
        $0.left.right.bottom.equalToSuperview()
        $0.top.equalToSuperview().inset(offset)
      }
    }
}
