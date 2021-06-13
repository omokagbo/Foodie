//
//  HomeDetailsViewController.swift
//  Foodie
//
//  Created by omokagbo on 13/06/2021.
//

import UIKit

class HomeDetailsViewController: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var dishDescription: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var orderButton: UIButton!
    
    var dish: PopularDish!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
    }
    
    @IBAction func placeOrderBtnTapped(_ sender: UIButton) {
    }
    
    private func populateView() {
        dishImageView.kf.setImage(with: dish.image?.asURL)
        dishNameLbl.text = dish.name
        caloriesLbl.text = dish.formattedCalories
        dishDescription.text = dish.description
    }

}
