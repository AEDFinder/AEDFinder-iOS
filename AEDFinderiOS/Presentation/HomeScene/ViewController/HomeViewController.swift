//
//  HomeViewController.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import UIKit
import SnapKit
import NMapsMap
import RxSwift

final class HomeViewController: BaseViewController {
    
    weak var coordinator: HomeCoordinator?
    private var viewModel: HomeViewModel!
    private var marker: NMFMarker = NMFMarker()
    
    private var mapView: NMFNaverMapView = {
        let view = NMFNaverMapView(frame: .init())
        view.showLocationButton = true
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    static func create(
        with viewModel: HomeViewModel,
        _ coordinator: HomeCoordinator
    ) -> HomeViewController {
        let vc = HomeViewController()
        vc.viewModel = viewModel
        vc.coordinator = coordinator
        return vc
    }
    
    override func setAttribute() {

    }
    
    override func setLayout() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setBind() {
        let input = HomeViewModel.Input(
            viewWillAppear: Observable.just(()))
        
        let output = self.viewModel.transform(from: input)
        
        output.showCurrentLocation
            .drive(onNext: { [weak self] location in
                guard let strongSelf = self else { return }
                let camera = strongSelf.updateCamera(location)
                strongSelf.mapView.mapView.moveCamera(camera)
            }).disposed(by: disposeBag)
    }
    
    func updateCamera(_ location: CLLocation) -> NMFCameraUpdate {
        let coord = NMGLatLng(
            lat: location.coordinate.latitude,
            lng: location.coordinate.longitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 2
        marker.position = coord
        marker.mapView = mapView.mapView
        return cameraUpdate
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
}
