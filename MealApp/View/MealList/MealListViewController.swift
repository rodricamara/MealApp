//
//  MealListViewController.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import Foundation

protocol MealListViewControllerDelegate: class {
    
    func mealListViewController(_ controller: MealListViewController, didSelect meal: Meal)
}

class MealListViewController: UIViewController, UITableViewDataSource  {
    
    weak var delegate: MealListViewControllerDelegate?
    weak var delegateTV: UITableViewDataSource?
    var mealDataManager = MealDataManager()
    var mealsArray = [Meal]()
    
    //MARK: - Properties
    var mealsSearchBar = UISearchBar(frame: .zero)
    var mealsTableView = UITableView(frame: .zero)
    
    //MARK: - Lifecycle
    override func loadView(){
        super.loadView()
        applyMealsConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealsTableView.dataSource = self
        title = titleMealListViewController
        getData()
    }
    
    //MARK: - Private Methods
    
    private func applyMealsConstraints() {
        view.addSubview(mealsSearchBar)
        mealsSearchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(getNavigationBarHeight())
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
    
    private func getData(){
        mealDataManager.fetchData(endpoint: endpoint) { (AFDataResponse) in
            
            switch AFDataResponse.result {
            case .success(let value as [String: Any]):
                print ("Status Code: \(AFDataResponse.response!.statusCode)")
                print("SUCCESS: \(value)")
                
                if let jsonResult = try? JSONSerialization.jsonObject(with: AFDataResponse.data!, options: []) as? [String:Any] {
                    if let arrayMeals = jsonResult["meals"] as? [AnyObject]{
                        for meal in arrayMeals {
                            let jsonMealData = try? JSONSerialization.data(withJSONObject: meal, options: .prettyPrinted)
                            if let meal = try? JSONDecoder().decode(Meal.self, from: jsonMealData!) {
                                print(meal)
                                self.mealsArray.append(meal)
                            }
                        }
                    }
                }
                self.mealsTableView.reloadData()
            case .failure(let error):
                print("FAILURE: \(error)")
            default:
                fatalError("Received non-dictionary JSON response")
            }
        }
    }
    
    func getNavigationBarHeight() -> CGFloat {
        if let navigationHeight = navigationController?.navigationBar.frame.height {
            return navigationHeight + UIApplication.shared.statusBarFrame.height
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MealCellView(style: .default, reuseIdentifier: MealCell)
        
        let urlString = mealsArray[indexPath.row].mealImageURL
        cell.mealImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: cellPlaceHolder), completed: nil)
        
        cell.mealName.text = mealsArray[indexPath.row].mealName
        
        cell.mealCategory.text = mealsArray[indexPath.row].mealCategory

        cell.needsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    
}

