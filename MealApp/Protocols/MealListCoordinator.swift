//
//  MealListCoordinator.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit

final class MealListCoordinator: Coordinator {
    
    private var presenter: UINavigationController
    private var mealDetailCoordinator: MealDetailCoordinator?
    private var mealListViewController: MealListViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let mealListViewController = MealListViewController(delegate: self)
        
        self.mealListViewController = mealListViewController
        presenter.pushViewController(mealListViewController, animated: true)
    }
}

extension MealListCoordinator: MealListViewControllerDelegate {
    
    func mealListViewController(_ controller: MealListViewController, didSelect meal: Meal) {
        let mealDetailCoordinator = MealDetailCoordinator(presenter: presenter, meal: meal)
        self.mealDetailCoordinator = mealDetailCoordinator
        mealDetailCoordinator.start()
    }
}
