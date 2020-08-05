//
//  MealDataManager.swift
//  MealApp
//
//  Created by Rodrigo Camara Robles on 05/08/2020.
//  Copyright © 2020 Rodrigo Camara Robles. All rights reserved.
//

import Alamofire

struct MealDataManager {
    
    //MARK: - Properties
    static var mealDataManager = MealDataManager()
    
    //MARK: - Public Methods
    
    func fetchData(endpoint: String, completion: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(endpoint,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding(options:.prettyPrinted),
                   headers: nil).validate().responseJSON { DefaultDataResponse in
                    completion(DefaultDataResponse)
        }
        
    }
}
