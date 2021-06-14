//
//  ChefSpecialsCollectionViewCell.swift
//  Foodie
//
//  Created by omokagbo on 06/06/2021.
//

import UIKit

class ChefSpecialsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ChefSpecialsCollectionViewCell"
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    
    func setup(_ dish: PopularDish) {
        dishImageView.kf.setImage(with: dish.image?.asURL)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }
}
