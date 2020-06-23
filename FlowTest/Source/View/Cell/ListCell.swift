//
//  ListCell.swift
//  FlowTest
//
//  Created by Euijae Hong on 2020/06/23.
//  Copyright © 2020 엄태형. All rights reserved.
//

import UIKit

class ListCell: BaseTableViewCell {
    
    var thumbnailView: UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }()
    
    var titleLabel: UILabel = {
        var l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17)
        l.textColor = .black
        l.text = "title"
        return l
    }()
    
    var countLabel: UILabel = {
        var l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = .black
        l.text = "count"
        return l
    }()
    
    var viewModel: ListCellViewModel! {
        didSet {
            self.titleLabel.text = viewModel.title
            self.countLabel.text = "\(viewModel.count)"
            self.thumbnailView.image = viewModel.thumbnail
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setupUI() {
        self.backgroundColor = .green
        [thumbnailView, titleLabel, countLabel].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
        thumbnailView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(thumbnailView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(20)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(titleLabel.snp.width)
            $0.height.equalTo(20)
        }
    }

}
