//
//  Bundle+.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import Foundation

extension Bundle {
    var mapApiKey: String {
        guard let file = self.path(forResource: "APIKey", ofType: "plist") else { return "" }
        guard let resourece = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resourece["MAP_API_KEY"] as? String else { fatalError("MAP_API_KEY에 Naver Map API_KEY 설정을 해주세요")}
        return key
    }
}
