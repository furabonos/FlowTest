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
    
    func numberOfItemsInSection() -> Int {
        return imgArray.count
    }
    
    func sizeForItemAt() -> CGSize {
        var cellWidth = (UIScreen.main.bounds.width - 8) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
//    func getAlbum(albumName: String, completion: @escaping (Bool) -> Void) {
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
                        completion(self.imgArray)
                        let imgData = NSData(data: photoLibraryImages[0].jpegData(compressionQuality: 1)!)
                        var imageSize: Int = imgData.count
                        var mbtest = Float(Double(imageSize)/1024/1024)
//                        print("fdsjfkdsjfkjsdfkjsdkf = \(Double(imageSize) / 1000.0) mb")
//                        print("fdsjfkdsjfkjsdfkjsdkf = \(Double(imageSize) / 1024 / 1024) mb")
//                        print("fffff = \(imgData.length)")
//                        print("kfklk = \(mbtest)")
                        print("size of image in KB: %f ", Double(imgData.count) / 1024.0)
                        print("size of image in MB: %f ", Double(imgData.length) / 1024.0 / 1024.0)
                        print("filename = \(photoLibraryAssets[0].value(forKey: "filename"))")
                       }
                   }
               }
           }
       }
    }
    
}
