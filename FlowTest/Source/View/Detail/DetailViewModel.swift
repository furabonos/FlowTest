//
//  DetailViewModel.swift
//  FlowTest
//
//  Created by 엄태형 on 2020/06/24.
//  Copyright © 2020 엄태형. All rights reserved.
//

import Foundation
import UIKit
import Photos

class DetailViewModel {
    
    var imgArray = Array<UIImage>()
    
    var infoArr = Array<Dictionary<String, AnyObject>>()
    var infoDic: [String: AnyObject] = [:]
    
    func numberOfItemsInSection() -> Int {
        return imgArray.count
    }
    
    func sizeForItemAt() -> CGSize {
        var cellWidth = (UIScreen.main.bounds.width - 8) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func getAlbum(albumName: String, completion: @escaping (Array<UIImage>) -> Void) {
        var photoLibraryImages = [UIImage]()
        var photoLibraryAssets = [PHAsset]()
       //whatever you need, you can use UIImage or PHAsset to photos in UICollectionView

       DispatchQueue.global(qos: .userInteractive).async
       {
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
                    if title == albumName {
                        if photoInAlbum.count > 0 {
                            for i in (0..<photoInAlbum.count).reversed() {
                                   imgManager.requestImage(for: photoInAlbum.object(at: i) as PHAsset , targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: requestOptions, resultHandler: {
                                       image, error in
                                       if image != nil {
                                        photoLibraryImages.append(image!)
                                        self.imgArray.append(image!)
                                        photoLibraryAssets.append(photoInAlbum.object(at: i))
                                       }
                                   })
                               }
                           }
                        for i in 0..<photoLibraryAssets.count {
                            guard let fileName = photoLibraryAssets[i].value(forKey: "filename") else { return }
                            let imgData = NSData(data: photoLibraryImages[i].jpegData(compressionQuality: 1)!)
                            let imgSize = Double(imgData.count) / 1000.0
                            self.infoDic.updateValue(fileName as AnyObject, forKey: "filename")
                            self.infoDic.updateValue(imgSize as AnyObject, forKey: "filesize")
                            self.infoArr.append(self.infoDic)
                        }
                        completion(self.imgArray)
                       }
                   }
               }
           }
       }
    }
    
}
