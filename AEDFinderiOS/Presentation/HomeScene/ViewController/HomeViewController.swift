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
import RxCocoa
import RxAppState

final class HomeViewController: BaseViewController {
    weak var coordinator: HomeCoordinator?
    private var viewModel: HomeViewModel!
    private var marker: NMFMarker = NMFMarker()
    
    private lazy var mapView: NMFNaverMapView = {
        let view = NMFNaverMapView(frame: .init())
        view.showLocationButton = true
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17.8
        view.mapView.logoInteractionEnabled = false
        view.mapView.logoAlign = .leftTop
        return view
    }()
    
    private lazy var bottomSheetView: HomeBottomSheetView = {
        let view = HomeBottomSheetView()
        view.barViewColor = .darkGray.withAlphaComponent(0.5)
        view.bottomSheetColor = .lightGray.withAlphaComponent(0.5)
        view.aedListCollectionView.delegate = self
        view.aedListCollectionView.register(AEDSelectCell.self, forCellWithReuseIdentifier: AEDSelectCell.identifier)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        super.setAttribute()

    }
    
    override func setLayout() {
        super.setLayout()
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(bottomSheetView)
        bottomSheetView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setBind() {
        super.setBind()
        
        let input = HomeViewModel.Input(
            viewWillAppear: rx.viewWillAppear.mapToVoid()
        )

        let output = viewModel.transform(from: input)
        
        output.showCurrentLocation
            .drive(onNext: { [weak self] location in
                guard let strongSelf = self else { return }
                let camera = strongSelf.updateCamera(location)
                strongSelf.mapView.mapView.moveCamera(camera)
            }).disposed(by: self.disposeBag)
        
        output.showArroundAEDLocation
            .drive(bottomSheetView.aedListCollectionView.rx.items(cellIdentifier: AEDSelectCell.identifier, cellType: AEDSelectCell.self)) { (index: Int, element: HomeInfo, cell) in
                cell.update(with: element)
            }.disposed(by: disposeBag)
        
        output.showErrorValue.asSignal()
            .emit(onNext: { [weak self] error in
                self?.showAlert(nil, error.message)
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bottomSheetView.aedListCollectionView.frame.size.width - 50, height: 80)
    }
}

