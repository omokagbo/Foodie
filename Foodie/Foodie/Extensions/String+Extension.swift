//
//  String+Extension.swift
//  Foodie
//
//  Created by omokagbo on 28/05/2021.
//

import Foundation

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}
