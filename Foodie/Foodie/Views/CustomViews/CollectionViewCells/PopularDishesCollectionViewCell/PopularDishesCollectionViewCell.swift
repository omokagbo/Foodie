//
//  PopularDishesCollectionViewCell.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 06/06/2021.
//

import UIKit

class PopularDishesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularDishesCollectionViewCell"
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(_ dish: Dish) {
        titleLbl.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asURL)
        caloriesLbl.text = dish.formattedCalories
        descriptionLbl.text = dish.description
    }
}
