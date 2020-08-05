//
//  MealListViewController.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit
import SnapKit

class MealListViewController: UIViewController {
    
    //MARK: - Properties
    var mealsSearchBar = UITableView(frame: .zero)
    var mealsTableView = UITableView(frame: .zero)
    
    //MARK: - Lifecycle
    override func loadView(){
        super.loadView()
        applyMealsConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meals"
    }
    
    //MARK: - Private Methods
    
    private func applyMealsConstraints() {
        view.addSubview(mealsSearchBar)
        mealsSearchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(searchBarHeight)
        }
        
        view.addSubview(mealsTableView)
        mealsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(mealsSearchBar.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
}
