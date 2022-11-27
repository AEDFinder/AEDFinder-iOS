//
//  HomeInfoResponseDTO.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation

struct HomeInfoResponseDTO: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let local: String
    
    func toDomain() -> HomeInfo {
        return HomeInfo(
            name: self.name,
            lat: self.lat,
            lon: self.lon,
            local: self.local)
    }
}
