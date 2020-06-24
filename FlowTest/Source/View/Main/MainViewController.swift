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
    
    var naviView: UIView = {
        var v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
    
    let listCell = "ListCell"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: self.listCell)
      return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        [tableView].forEach { self.view.addSubview($0) }
    }
    
    override func setupConstraints() {
        makeNavBar()
        tableView.snp.makeConstraints {
            $0.top.equalTo(navbar.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    override func bind() {
        self.fetchData()
    }
    
    func makeNavBar() {
        navbar.backgroundColor = .white
        let navItem = UINavigationItem()
        navItem.title = "앨범"
        navbar.items = [navItem]
        view.addSubview(navbar)
        navbar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func fetchData() {
        self.viewModel.getInfo { (result) in
            switch result {
            case true:
                self.reloadTableView()
            default: break
            }
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableView.reloadData()
        }
    }
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
        cell.selectionStyle = .none
        cell.viewModel = ListCellViewModel(content: self.viewModel.infoArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let albumName = self.viewModel.infoArr[indexPath.row]["Title"] else { return }
        self.navigationController?.pushViewController(navigator.navigate(at: .detail(albumName: albumName as! String)), animated: true)
    }
}
