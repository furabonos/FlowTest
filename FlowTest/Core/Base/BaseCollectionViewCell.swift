//
//  BaseCollectionViewCell.swift
//  FlowTest
//
//  Created by 엄태형 on 2020/06/24.
//  Copyright © 2020 엄태형. All rights reserved.
//

import UIKit
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      
      setupUI()
      setupConstraints()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)

      setupUI()
      setupConstraints()
    }
    
    
    //MARK:- Methods
    
    func setupUI() { }
    
    func setupConstraints() { }
    
}
