//
//  ApplicationCoordinator.swift
//  MealApp
//
//  Created Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var mealListCoordinator: MealListCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        mealListCoordinator = MealListCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        mealListCoordinator?.start()
        window.makeKeyAndVisible()
    }
    
}
