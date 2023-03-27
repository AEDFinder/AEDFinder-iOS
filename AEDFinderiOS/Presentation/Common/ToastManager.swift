//
//  ToastManager.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2023/03/27.
//

import UIKit

final class ToastManager {
    public static let shared = ToastManager()
    
    private var shownToast: Toast?
    private var toastContainer = UIView()
    private var window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    
    public func show(
        _ toastInput: Toast.Input,
        authHidden: Bool = true
    ) {
        DispatchQueue.main.async { [weak self] in
            if let topVC = UIViewController.getTopViewController(),
               self?.shownToast == nil {
                self?.showUp(toastInput, by: topVC, authHidden: authHidden)
            }
        }
    }
    
    private func showUp(
        _ toastInput: Toast.Input,
        by curVC: UIViewController,
        authHidden: Bool = true
    ) {
        guard let window = window else { return }
        
        var _onTap: (() -> Void)? = { [weak self] in
            self?.hideDownWithAnimation()
        }
        
        if let onTap = toastInput.onTapConfirmButton {
            _onTap = { [weak self] in
                self?.hideDownWithAnimation()
                onTap()
            }
        }
        
        let toast = Toast(.init(
            title: toastInput.title,
            colors: toastInput.colors,
            confirmButtonTitle: toastInput.confirmButtonTitle,
            onTapConfirmButton: _onTap
        ))
        
        DispatchQueue.main.async {
            window.addSubview(self.toastContainer)
            self.toastContainer.addSubview(toast)
            
            self.toastContainer.snp.makeConstraints {
                $0.left.right.equalTo(window.safeAreaLayoutGuide).inset(20)
                $0.top.equalTo(window.safeAreaLayoutGuide)
            }
            window.bringSubviewToFront(toast)
            
            self.shownToast = toast
            self.showUpWithAnimation()
            
            if authHidden {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) { [weak self] in
                    self?.hideDownWithAnimation()
                }
            }
        }
    }
    
    private func showUpWithAnimation() {
        guard let _ = self.window,
              let shownToast = self.shownToast else { return }
        
        DispatchQueue.main.async {
            shownToast.snp.makeConstraints {
                $0.left.right.top.bottom.equalToSuperview()
                $0.height.equalTo(shownToast.bodyHeight)
            }
            
            shownToast.layoutSubviews()
            
            shownToast.snp.updateConstraints {
                $0.top.equalToSuperview().offset(-shownToast.bodyHeight)
                $0.height.equalTo(shownToast.bodyHeight)
            }
            
            self.toastContainer.layoutSubviews()
            
            UIView.animate(
              withDuration: 0.3,
              delay: 0,
              usingSpringWithDamping: 0.8,
              initialSpringVelocity: 0.6,
              options: .curveEaseIn,
              animations: {
                self.shownToast?.snp.updateConstraints { make in
                  make.top.equalToSuperview()
                }
                self.toastContainer.layoutIfNeeded()
              }
            )
        }
    }
    
    private func hideDownWithAnimation() {
        DispatchQueue.main.async {
            UIView.animate(
                withDuration: 0.15,
                delay: 0,
                options: .curveEaseOut,
                animations: { [weak self] in
                    guard let self = self,
                          let _ = self.window,
                          let shownToast = self.shownToast else { return }
                    
                    shownToast.snp.updateConstraints {
                        $0.top.equalTo(-2 * shownToast.bodyHeight)
                    }
                    self.toastContainer.layoutIfNeeded()
                }) { [weak self] _ in // completion
                    self?.shownToast?.removeFromSuperview()
                    self?.shownToast = nil
                }
        }
    }
}
