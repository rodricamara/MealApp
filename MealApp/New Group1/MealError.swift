//
//  MealError.swift
//  MealApp
//
//  Created by Rodrigo Camara on 25/03/2022.
//  Copyright © 2022 Rodrigo Camara Robles. All rights reserved.
//

enum MealError: Error {
    case decodingError
    case dataIsNil
    case serviceError
    
    var errorDescription: String {
        switch self {
        case .dataIsNil:
            return "Error: The data is nil."
        case .decodingError:
            return "Error: Failed when parsing."
        case .serviceError:
            return "Error: There's an error in the service."
        }
    }
}
