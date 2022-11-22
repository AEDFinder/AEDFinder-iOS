//
//  BaseViewController.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAttribute()
        self.setLayout()
        self.setBind()
    }
    
    func setAttribute() {}
    
    func setLayout() {}
    
    func setBind() {}

    func showAlert(_ title: String?, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertVC, animated: true, completion: nil)
    }
}
