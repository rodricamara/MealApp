//
//  MealListViewController.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit
import SnapKit

protocol MealListViewControllerDelegate: AnyObject {
    func mealListViewController(_ controller: MealListViewController, didSelect meal: Meal)
}

final class MealListViewController: UIViewController {
    
    private weak var delegate: MealListViewControllerDelegate?
    private weak var delegateTV: UITableViewDataSource?
    private var mealDataManager = MealDataManager()
    private var mealsArray = [Meal]()
    
    private lazy var mealsSearchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        applyMealsConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleMealListViewController
        getData("")
    }
    
    init(delegate: MealListViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MealListViewController {
    func applyMealsConstraints() {
        view.addSubview(mealsSearchBar)
        mealsSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(getNavigationBarHeight())
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(searchBarHeight)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mealsSearchBar.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    func getData(_ meal: String){
        mealsArray = []
        let finalEndpoint = "\(endpoint)\(meal)"
        mealDataManager.fetchData(endpoint: finalEndpoint) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value as [String: Any]):
                if let jsonResult = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String:Any] {
                    if let arrayMeals = jsonResult["meals"] as? [AnyObject]{
                        for meal in arrayMeals {
                            let jsonMealData = try? JSONSerialization.data(withJSONObject: meal, options: .prettyPrinted)
                            if let meal = try? JSONDecoder().decode(Meal.self, from: jsonMealData!) {
                                self.mealsArray.append(meal)
                            }
                        }
                    }
                }
                self.tableView.reloadData()
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
}

extension MealListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MealCellView(style: .default, reuseIdentifier: mealCell)
        cell.configure(.init(name: mealsArray[indexPath.row].mealName,
                             category: mealsArray[indexPath.row].mealCategory,
                             image: mealsArray[indexPath.row].mealImageURL))
        return cell
    }
}

extension MealListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = mealsArray[indexPath.item]
        delegate?.mealListViewController(self, didSelect: meal)
    }
}

extension MealListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getData(searchText)
    }
}
