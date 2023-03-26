//
//  MapAdaptorBuilder.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2023/03/26.
//

import UIKit
import NMapsMap

/// 추후 어떤 서비스가 맵에 추가될지 모르므로 어댑터 생성
final class MapAdaptorBuilder {
    private static var shared: MapAdaptor?
    
    static func build(mapView: NMFMapView) -> MapAdaptor {
        let instance = NaverMapAdaptor(mapView: mapView)
        shared = instance
        return instance
    }
    
    static func get() -> MapAdaptor? {
        return shared
    }
}

protocol MapAdaptor {
    var mapView: NMFMapView { get set }
}

final class NaverMapAdaptor: MapAdaptor {
    
    init(mapView: NMFMapView) {
        self.mapView = mapView
    }
    
    public var mapView: NMFMapView
}
