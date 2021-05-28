//
//  CategoryCollectionViewCell.swift
//  Foodie
//
//  Created by Decagon on 28/05/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImgView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(_ category: DishCategory) {
        categoryImgView.image = UIImage(named: category.image)
        categoryTitleLbl.text = category.name
    }

}
