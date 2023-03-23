//
//  AEDSelectCell.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/21.
//

import UIKit
import Then
import SnapKit

 class AEDSelectCell: UICollectionViewCell {
    static let identifier = "AEDSelectCell"
    
    private let title = UILabel().then {
        $0.font = .SD_Gothic(.light, size: 14)
        $0.textColor = .red
        $0.textAlignment = .left
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         self.setLayout()
     }
     
    private func setLayout() {
        self.contentView.backgroundColor = .yellow
        [title]
            .forEach {
                self.contentView.addSubview($0)
            }
        
        title.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
    }
    
    func update(with aed: HomeInfo) {
        title.text = "\(aed.local)"
    }
    
}
