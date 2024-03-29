//
//  ApiResponse.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 04/08/2021.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
