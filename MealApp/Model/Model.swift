//
//  Model.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

struct Meal: Codable {
    
    //MARK: - Properties
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mealName = try values.decode(String.self, forKey: .mealName)
        mealCategory = try values.decode(String.self, forKey: .mealCategory)
        mealImageURL = try values.decode(String.self, forKey: .mealImageURL)
        mealInstructions = try values.decode(String.self, forKey: .mealInstructions)
        mealVideoURL = try values.decode(String.self, forKey: .mealVideoURL)
    }
}
