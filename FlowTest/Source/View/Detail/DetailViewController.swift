//
//  DetailViewController.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/24.
//  Copyright © 2020 엄태형. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var albumName: String
    
    init(albumName: String) {
        self.albumName = albumName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        print("Z")
        view.backgroundColor = .blue
//        self.navigationController?.navigationBar.topItem?.title = self.albumName
        print("빠끄 = \(self.albumName)")
    }
    
    override func setupConstraints() {
        print("ff")
    }

}
