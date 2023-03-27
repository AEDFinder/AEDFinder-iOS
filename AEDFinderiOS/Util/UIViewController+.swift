//
//  UIViewController+.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2023/03/27.
//

import UIKit

extension UIViewController {
    typealias NextViewController = UIViewController
    
    public static func getTopViewController() -> UIViewController? {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
        let rootVC = window.rootViewController
        else { return nil }
        
        var topVC: UIViewController? = rootVC
        
        DispatchQueue.main.async {
            while topVC?.presentedViewController != nil || topVC is UINavigationController {
                if let naviVC = topVC as? UINavigationController {
                    topVC = naviVC.topViewController
                } else {
                    topVC = topVC?.presentedViewController
                }
            }
            
        }
        
        return topVC
    }
}
