//
//  MealDetailViewController.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    //MARK: - Properties
    var scrollView = UIScrollView(frame: .zero)
    var mealName = UILabel(frame: .zero)
    var mealInstructions = UILabel(frame: .zero)
    
    //MARK: Initializer
    convenience init(mealName: String?, mealInstruction: String?) {
        self.init()
        self.mealName.text = mealName
        self.mealInstructions.text = mealInstruction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
