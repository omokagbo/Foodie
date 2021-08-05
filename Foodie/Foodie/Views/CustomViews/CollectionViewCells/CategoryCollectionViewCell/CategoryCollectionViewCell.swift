//
//  CategoryCollectionViewCell.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 28/05/2021.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImgView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    
    static let identifier = "CategoryCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(_ category: DishCategory) {
        categoryTitleLbl.text = category.title
        categoryImgView.kf.setImage(with: category.image?.asURL)
    }

}
