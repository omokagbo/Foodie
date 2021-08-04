//
//  HUD.swift
//  Foodie
//
//  Created by omokagbo on 04/08/2021.
//

import UIKit
import ProgressHUD


extension UIViewController {
    
    func presentHUD(status: String?) {
        DispatchQueue.main.async {
            ProgressHUD.show(status)
        }
    }
    
    func dismissHUD(){
        DispatchQueue.main.async {
            ProgressHUD.dismiss()
        }
    }
    
}
