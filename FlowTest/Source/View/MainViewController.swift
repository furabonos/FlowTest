//
//  MainViewController.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/23.
//  Copyright © 2020 엄태형. All rights reserved.
//

import UIKit
import Photos

class MainViewController: BaseViewController {
    
    private let viewModel = MainViewModel()
    
    let listCell = "ListCell"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: self.listCell)
      return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("mainmain")
        let albumList = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
//        print("fjdkfjdskfjdsk = \(albumList.count)")//앨범갯수
//        print("fjdkfjdskfjdsk = \(albumList.object(at: 0).localizedTitle)")//앨범타이틀
//        print("fjdkfjdskfjdsk = \(albumList.object(at: 1).localizedTitle)")
    }
    
    override func setupUI() {
        [tableView].forEach { self.view.addSubview($0) }
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        viewModel.getInfo()
//        get_Photos_From_Album(albumName: "Test3")
        
//        print("fdkfjdksfjksdfjkdsfjkds = \(viewModel.testArr[0].photoCount)")
    }
    
//    func get_Photos_From_Album(albumName: String)
//           {
//               var photoLibraryImages = [UIImage]()
//               var photoLibraryAssets = [PHAsset]()
//               //whatever you need, you can use UIImage or PHAsset to photos in UICollectionView
//
//               DispatchQueue.global(qos: .userInteractive).async
//               {
//                   let fetchOptions = PHFetchOptions()
//                   fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
//
//                   let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
//                   let customAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
//
//                   [smartAlbums, customAlbums].forEach {
//                       $0.enumerateObjects { collection, index, stop in
//
//                           let imgManager = PHImageManager.default()
//
//                           let requestOptions = PHImageRequestOptions()
//                           requestOptions.isSynchronous = true
//                           requestOptions.deliveryMode = .highQualityFormat
//
//                           let photoInAlbum = PHAsset.fetchAssets(in: collection, options: fetchOptions)
//
//                           if let title = collection.localizedTitle
//                           {
//                               if photoInAlbum.count > 0
//                               {
//                                   print("\n\n \(title) --- count = \(photoInAlbum.count) \n\n")
//                               }
//
//                               if title == albumName
//                               {
//                                   if photoInAlbum.count > 0
//                                   {
//                                       for i in (0..<photoInAlbum.count).reversed()
//                                       {
//                                           imgManager.requestImage(for: photoInAlbum.object(at: i) as PHAsset , targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: requestOptions, resultHandler: {
//                                               image, error in
//                                               if image != nil
//                                               {
//                                                   photoLibraryImages.append(image!)
//                                                DispatchQueue.main.async {
////                                                    self.thumbnailView.image = photoLibraryImages.last
//                                                }
//                                        
//                                                photoLibraryAssets.append(photoInAlbum.object(at: i))
//                                               }
//                                           })
//                                       }
//                                   }
//                               }
//                           }
//                       }
//                   }
//               }
//           }

}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.listCell, for: indexPath as IndexPath) as! ListCell
        return cell
    }
}
