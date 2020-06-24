//
//  MainViewModel.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/23.
//  Copyright © 2020 엄태형. All rights reserved.
//

import Foundation
import UIKit
import Photos

class MainViewModel {
    
    let albumList = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
    var infoArr = Array<Dictionary<String, AnyObject>>()
    var infoDic: [String: AnyObject] = [:]
    
    var albumCount = 0
    var title = ""
    var titleArr = Array<String>()
    var countArr = Array<Int>()
    
    func numberOfRowsInSection() -> Int {
        return infoArr.count
    }
    
//    func getInfo(completion: @escaping ([Dictionary<String, AnyObject>]) -> Void) {
    func getInfo(completion: @escaping (Bool) -> Void) {
        var photoLibraryImages = [UIImage]()
        var photoLibraryAssets = [PHAsset]()
        
        DispatchQueue.global(qos: .userInteractive).async {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)

            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            let customAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            
            [smartAlbums, customAlbums].forEach {
                $0.enumerateObjects { collection, index, stop in
                    let imgManager = PHImageManager.default()

                    let requestOptions = PHImageRequestOptions()
                    requestOptions.isSynchronous = true
                    requestOptions.deliveryMode = .highQualityFormat

                    let photoInAlbum = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                    if let title = collection.localizedTitle {
                        if photoInAlbum.count > 0 {
                            for i in (0..<photoInAlbum.count).reversed() {
                                imgManager.requestImage(for: photoInAlbum.object(at: i) as PHAsset , targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: requestOptions, resultHandler: { image, error in
                                   if image != nil {
                                    photoLibraryImages.append(image!)
                                    DispatchQueue.main.async {
                                        
                                    }
                                    photoLibraryAssets.append(photoInAlbum.object(at: i))
                                   }
                               })
                            }
                            self.infoDic.updateValue(title as AnyObject, forKey: "Title")
                            self.infoDic.updateValue(photoInAlbum.count as AnyObject, forKey: "Count")
                            if title == "Recents" {
                                self.infoDic.updateValue(photoLibraryImages.first as AnyObject, forKey: "Thumb")
                            }else {
                                self.infoDic.updateValue(photoLibraryImages.last as AnyObject, forKey: "Thumb")
                            }
                            self.infoArr.append(self.infoDic)
                        }
                        
                    }
                }
            }
            completion(true)
            print("fjdkfjdksfjkdsfjdksfjkdsfjksd = \(self.infoArr)")
        }
    }
}
