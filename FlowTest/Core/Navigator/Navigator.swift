//
//  Navigator.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/23.
//  Copyright © 2020 엄태형. All rights reserved.
//

import UIKit

struct Navigator {

  enum Scene {
    case main
//    case write
  }

  func navigate(at scene: Scene) -> UIViewController {
    switch scene {
    case .main:
      let viewController: MainViewController = MainViewController()
      return viewController
//    case .write:
//        let viewController: WriteViewController = WriteViewController()
//        return viewController
    }
  }

}
