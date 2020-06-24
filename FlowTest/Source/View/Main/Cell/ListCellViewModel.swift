//
//  ListCellViewModel.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/23.
//  Copyright © 2020 엄태형. All rights reserved.
//

import Foundation
import UIKit

class ListCellViewModel {
    
    var title: String
    var count: Int
    var thumbnail: UIImage
    
    init(content: Dictionary<String, AnyObject>) {
        self.title = content["Title"] as! String
        self.count = content["Count"] as! Int
        self.thumbnail = content["Thumb"] as! UIImage
    }
}
