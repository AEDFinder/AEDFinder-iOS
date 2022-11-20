//
//  ViewModelType.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import RxSwift

protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
