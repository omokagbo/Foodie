//
//  Orders.swift
//  Foodie
//
//  Created by omokagbo on 14/06/2021.
//

import Foundation

struct Order: Codable {
    let id: String?
    let name: String?
    let dish: Dish?
}