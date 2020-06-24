//
//  BaseViewController.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/23.
//  Copyright © 2020 엄태형. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    var navigator = Navigator()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bind()
    }
    
    func setupUI() {}
    func setupConstraints() {}
    func bind() {}

}
