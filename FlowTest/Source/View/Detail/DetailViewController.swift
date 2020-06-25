//
//  DetailViewController.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/24.
//  Copyright © 2020 엄태형. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    let viewModel = DetailViewModel()
    
    var albumName: String
    
    let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
    
    let detailCell = "DetailCell"
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        var cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .red
        cv.register(DetailCell.self, forCellWithReuseIdentifier: detailCell)
        return cv
    }()
    
    init(albumName: String) {
        self.albumName = albumName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        view.backgroundColor = .blue
        [collectionView].forEach { self.view.addSubview($0) }
    }
    
    override func setupConstraints() {
        makeNavBar()
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navbar.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    override func bind() {
        fetchImageData()
    }
    
    func fetchImageData() {
        viewModel.getAlbum(albumName: self.albumName) { (result) in
            self.reloadCollectionview()
        }
    }
    
    func makeNavBar() {
        navbar.backgroundColor = .white
        let navItem = UINavigationItem()
        navItem.title = self.albumName
        navItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backBtn))
        navbar.items = [navItem]
        view.addSubview(navbar)
        navbar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func reloadCollectionview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.reloadData()
        }
    }
    
    @objc func backBtn() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension DetailViewController: UICollectionViewDelegate {}
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.detailCell, for: indexPath as IndexPath) as! DetailCell
        cell.albumView.image = viewModel.imgArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let fileName = self.viewModel.infoArr[indexPath.row]["filename"] else { return }
        guard let fileSize = self.viewModel.infoArr[indexPath.row]["filesize"] else { return }
        let alert = UIAlertController(title: "사진정보", message: "파일명: \(fileName) \n 파일크기: \(fileSize) KB", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt()
    }
}
