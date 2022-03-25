//
//  MealCellView.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit
import SnapKit

protocol MealCellProtocol {
    func configure(_ viewModel: MealViewModel)
}

final class MealCellView: UITableViewCell {
    
    private lazy var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = UIFont(name: fontAppleSD, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var category: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .gray
        label.font = UIFont(name: fontAvenir, size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var viewModel: MealViewModel? {
        didSet {
            name.text = viewModel?.name
            category.text = viewModel?.category
            image.sd_setImage(
                with: URL(string: viewModel?.image ?? ""),
                placeholderImage: UIImage(named: cellPlaceHolder),
                completed: nil)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MealCellView {
    func setUpView() {
        buildViewHierarchy()
        setUpConstraints()
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(category)
    }
    
    func setUpConstraints() {
        image.snp.makeConstraints { make -> Void in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        name.snp.makeConstraints { make -> Void in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(image.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
        
        category.snp.makeConstraints { make -> Void in
            make.top.equalTo(name.snp.bottom).offset(5)
            make.left.equalTo(image.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
    }
}

extension MealCellView: MealCellProtocol {
    func configure(_ model: MealViewModel) {
        self.viewModel = model
    }
}
