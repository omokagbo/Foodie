//
//  UIView + Extension.swift
//  Foodie
//
//  Created by omokagbo on 28/05/2021.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    public var identifier: String {
        return String(describing: self)
    }
}
