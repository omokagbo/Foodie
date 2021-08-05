//
//  Route.swift
//  Foodie
//
//  Created by omokagbo on 04/08/2021.
//

import Foundation

enum Route {
    
    static let baseUrl = "https://yummie.glitch.me"
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchDishCategories(String)
    case fetchAllOrders
    
    var description: String {
        switch self {
        case .fetchAllCategories:
            return "/dish-categories"
        case .placeOrder(let dishId):
            return "/orders/\(dishId)"
        case .fetchDishCategories(let categoryId):
            return "/dishes/\(categoryId)"
        case .fetchAllOrders:
            return "/orders"
        }
    }
    
}
