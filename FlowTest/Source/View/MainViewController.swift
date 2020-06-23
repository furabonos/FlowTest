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
    }
    
    override func setupUI() {
        [tableView].forEach { self.view.addSubview($0) }
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    override func bind() {
        self.fetchData()
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
        cell.viewModel = ListCellViewModel(content: self.viewModel.infoArr[indexPath.row])
        return cell
    }
}
