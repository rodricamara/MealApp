//
//  MealDetailCoordinator.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit

class MealDetailCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var mealDetailViewController: MealDetailViewController?
    private let meal: Meal
    
    init(presenter: UINavigationController, meal: Meal) {
        self.presenter = presenter
        self.meal = meal
    }
    
    func start() {
        let mealDetailViewController = MealDetailViewController(mealName: self.meal.mealName, mealInstruction: self.meal.mealInstructions)
        self.mealDetailViewController = mealDetailViewController
        presenter.pushViewController(mealDetailViewController, animated: true)
    }
}
