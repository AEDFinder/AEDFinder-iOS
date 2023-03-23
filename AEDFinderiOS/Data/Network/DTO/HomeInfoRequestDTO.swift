//
//  HomeInfoRequestDTO.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/21.
//

import Foundation

struct HomeInfoRequestDTO: Encodable {
    let lat: Double
    let lon: Double
    let radius: Int
    
    func toDictionary() -> [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return dictionary
    }
}
