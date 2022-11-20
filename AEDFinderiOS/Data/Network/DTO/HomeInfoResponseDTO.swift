//
//  HomeInfoResponseDTO.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation

struct HomeInfoResponseDTO: Decodable {
    
    func toDomain() -> HomeInfo {
        return HomeInfo(latitude: 100.0, longitude: 100.0)
    }
}
