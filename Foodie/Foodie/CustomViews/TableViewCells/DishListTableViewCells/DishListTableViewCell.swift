//
//  DishListTableViewCell.swift
//  Foodie
//
//  Created by omokagbo on 13/06/2021.
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    
    static let identifier = "DishListTableViewCell"
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLbl: UILabel!
    @IBOutlet weak var dishDescriptionLbl: UILabel!
    
    func setup(with dish: PopularDish) {
        dishImageView.kf.setImage(with: dish.image?.asURL)
        dishNameLbl.text = dish.name
        dishDescriptionLbl.text = dish.description
    }
}
