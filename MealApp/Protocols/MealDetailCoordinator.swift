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
    
    
    init(presenter: UINavigationController, meal: Meal) {
        self.presenter = presenter
    }
    
    
    func start() {
    }
}