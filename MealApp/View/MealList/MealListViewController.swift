//
//  MealListViewController.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copytrailing © 2020 Rodrigo Camara Robles. All trailings reserved.
//

import UIKit
import SnapKit

protocol MealListViewControllerDelegate: AnyObject {
    func mealListViewController(_ controller: MealListViewController, didSelect meal: Meal)
}

final class MealListViewController: UIViewController {
    
    private weak var delegate: MealListViewControllerDelegate?
    private var datasource: MealDatasourceProtocol?
    
    private var meals = [Meal]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var searchBar: UISearchBar = {
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
        view.backgroundColor = .white
        title = titleMealListViewController
        getData()
    }
    
    init(delegate: MealListViewControllerDelegate,
         datasource: MealDatasourceProtocol = MealDatasource()) {
        self.delegate = delegate
        self.datasource = datasource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MealListViewController {
    func applyMealsConstraints() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(getNavigationBarHeight())
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(searchBarHeight)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    func getData(_ meal: String = "") {
        datasource?.fetchData(searchTxt: meal) { response in
            switch response {
            case .success(let meals):
                self.meals = meals
            case .failure(_):
                self.meals = []
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
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MealCellView(style: .default, reuseIdentifier: mealCell)
        cell.configure(.init(name: meals[indexPath.row].mealName,
                             category: meals[indexPath.row].mealCategory,
                             image: meals[indexPath.row].mealImageURL))
        return cell
    }
}

extension MealListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = meals[indexPath.item]
        delegate?.mealListViewController(self, didSelect: meal)
    }
}

extension MealListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getData(searchText)
    }
}
