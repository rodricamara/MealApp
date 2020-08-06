//
//  MealCellView.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit
import SnapKit

class MealCellView: UITableViewCell {
    
    //MARK: - Properties
    var mealImage = UIImageView(frame: .zero)
    var mealName = UILabel(frame: .zero)
    var mealCategory = UILabel(frame: .zero)
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Public methods
    
    override public func updateConstraints() {
        super.updateConstraints()
        applyMealsCellConstraints()
    }
    
    //MARK: - Private methods
    
    private func initializeViews() {
        mealImage.translatesAutoresizingMaskIntoConstraints = false
        
        mealName.textColor = .black
        mealName.font = UIFont(name: fontAppleSD, size: 15)
        
        mealCategory.textColor = .gray
        mealCategory.font = UIFont(name: fontAvenir, size: 11)
    }
    
    private func applyMealsCellConstraints() {
        
        contentView.addSubview(mealImage)
        mealImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        contentView.addSubview(mealName)
        mealName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(mealImage.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
        
        contentView.addSubview(mealCategory)
        mealCategory.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mealName.snp.bottom).offset(5)
            make.left.equalTo(mealImage.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)

        }
    }
}
