//
//  DetailCell.swift
//  FlowTest
//
//  Created by 엄태형 on 2020/06/24.
//  Copyright © 2020 엄태형. All rights reserved.
//

import UIKit

class DetailCell: BaseCollectionViewCell {
    
    var albumView: UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .gray
        return iv
    }()
    
    override func setupUI() {
        [albumView].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
        albumView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
