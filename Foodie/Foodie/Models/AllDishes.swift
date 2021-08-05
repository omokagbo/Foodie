//
//  File.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 04/08/2021.
//

import Foundation

struct AllDishes: Codable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}
