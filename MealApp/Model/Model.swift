//
//  Model.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

struct Meal: Codable {
    var mealName: String
    var mealCategory: String
    var mealImageURL: String
    var mealInstructions: String
    var mealVideoURL: String
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealCategory = "strCategory"
        case mealImageURL = "strMealThumb"
        case mealInstructions = "strInstructions"
        case mealVideoURL = "strYoutube"
    }
}
