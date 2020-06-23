//
//  Model.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/23.
//  Copyright © 2020 엄태형. All rights reserved.
//

import Foundation
import UIKit

struct MainPhotoModel: Decodable {
    var title: String
    var photoCount: Int
    var thumbnails: UIImage? = nil
    
    enum CodingKeys: String, CodingKey {
        case title, photoCount
        
    }
}
