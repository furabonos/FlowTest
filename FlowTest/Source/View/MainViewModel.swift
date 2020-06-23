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
    var testArr = Array<Dictionary<String, AnyObject>>()
    var testDic: [String: AnyObject] = [:]
    
    var albumCount = 0
    var title = ""
    var titleArr = Array<String>()
    var countArr = Array<Int>()
    
    func numberOfRowsInSection() -> Int {
        return albumList.count
    }
    
    func getInfo() {
        self.albumCount = albumList.count
        //print("fjdkfjdskfjdsk = \(albumList.object(at: 0).localizedTitle)")//앨범타이틀
        for i in 0..<self.albumCount {
            guard let albumTitle = albumList.object(at: i).localizedTitle else { return }
            self.titleArr.append(albumTitle)
//            get_Photos_From_Album(albumName: albumTitle)
        }
//        print("fdjkfdjskfjdsk = \(self.titleArr)")
//        print("fdjkfdjskfjdsk = \(self.countArr)")
        get_Photos_From_Album(albumName: self.titleArr[0])
        get_Photos_From_Album(albumName: self.titleArr[1])
        get_Photos_From_Album(albumName: self.titleArr[2])
        get_Photos_From_Album(albumName: self.titleArr[3])
        
    }
    
    func get_Photos_From_Album(albumName: String)
               {
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
//                            self.countArr.append(photoInAlbum.count)
                            print("에에에에에2 = \(photoInAlbum.count)")
                               if let title = collection.localizedTitle
                               {
                                   if photoInAlbum.count > 0
                                   {
                                       print("\n\n \(title) --- count = \(photoInAlbum.count) \n\n")
                                   }

                                   if title == albumName
                                   {
                                       if photoInAlbum.count > 0
                                       {
                                           for i in (0..<photoInAlbum.count).reversed()
                                           {
                                               imgManager.requestImage(for: photoInAlbum.object(at: i) as PHAsset , targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: requestOptions, resultHandler: {
                                                   image, error in
                                                   if image != nil
                                                   {
                                                       photoLibraryImages.append(image!)
                                                    DispatchQueue.main.async {
    //                                                    self.thumbnailView.image = photoLibraryImages.last
                                                    }
                                            
                                                    photoLibraryAssets.append(photoInAlbum.object(at: i))
                                                   }
                                               })
                                           }
                                       }
                                   }
                               }
                           }
                       }
                   }
               }
}
