//
//  HomeUseCase.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation
import RxSwift

protocol HomeUseCase: AnyObject {
    func fetchHomeInfo() -> Observable<Result<HomeInfo, Error>>
}

final class DefaultHomeUseCase: HomeUseCase {
    private let homeRepository: HomeRepository
    
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }
    
    func fetchHomeInfo() -> Observable<Result<HomeInfo, Error>> {
        return self.homeRepository.fetchHomeInfo()
    }
}
