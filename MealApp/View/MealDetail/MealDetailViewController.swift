//
//  MealDetailViewController.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    private var scrollView = UIScrollView(frame: .zero)
    private var mealName = UILabel(frame: .zero)
    private var mealInstructions = UILabel(frame: .zero)
    
    convenience init(mealName: String?, mealInstruction: String?) {
        self.init()
        self.mealName.text = mealName
        self.mealInstructions.text = mealInstruction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
