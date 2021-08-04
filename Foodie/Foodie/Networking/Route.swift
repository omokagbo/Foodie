//
//  Route.swift
//  Foodie
//
//  Created by omokagbo on 04/08/2021.
//

import Foundation

enum Route {
    
    static let baseUrl = "https://yummie.glitch.me"
    
    case temp
    
    var description: String {
        switch self {
        case .temp:
            return "/dishes/cat1"
        }
    }
    
}
