//
//  PopularDish.swift
//  Foodie
//
//  Created by omokagbo on 06/06/2021.
//

import Foundation

struct Dish: Codable {
    let id, name, description, image: String?
    let calories: Int?
    
    var formattedCalories: String {
        return String(format: "\(calories ?? 0) calories")
    }
}
