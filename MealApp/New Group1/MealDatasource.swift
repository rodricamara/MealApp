//
//  MealDataManager.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import Alamofire

typealias MealResponse = Result<[Meal], MealError>

protocol MealDatasourceProtocol {
    func fetchData(searchTxt: String, completion: @escaping (MealResponse) -> Void)
}

class MealDatasource {
    init() {}
}

extension MealDatasource: MealDatasourceProtocol {
    
    func fetchData(searchTxt: String, completion: @escaping (MealResponse) -> Void) {
        AF.request(String.endpoint+searchTxt).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    return completion(.failure(.dataIsNil))
                }
                var meals = [Meal]()
                
                guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let mealsResult = jsonResult["meals"] as? [AnyObject]
                else {
                    completion(.failure(.decodingError))
                    return
                }
                for meal in mealsResult {
                    guard let jsonMealData = try? JSONSerialization.data(withJSONObject: meal, options: .prettyPrinted),
                          let meal = try? JSONDecoder().decode(Meal.self, from: jsonMealData)
                    else {
                        return
                    }
                    meals.append(meal)
                }
                completion(.success(meals))
            case .failure(_):
                completion(.failure(.serviceError))
            }
        }
    }
}

fileprivate extension String {
    static let endpoint = "https://www.themealdb.com/api/json/v1/1/search.php?s="
}
