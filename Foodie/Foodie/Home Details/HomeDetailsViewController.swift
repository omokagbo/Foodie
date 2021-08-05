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
    
    var dish: Dish?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
        
    }
    
    private func populateView() {
        dishImageView.kf.setImage(with: dish?.image?.asURL)
        dishNameLbl.text = dish?.name
        caloriesLbl.text = dish?.formattedCalories
        dishDescription.text = dish?.description
    }
    
    @IBAction func placeOrderBtnTapped(_ sender: UIButton) {
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty,
              name != "" else {
            self.showHUDError(status: "Please Enter Your Name")
            return
        }
        self.presentHUD(status: "Placing order")
        NetworkService.shared.placeOrder(dishId: dish?.id ?? "", name: name) { [weak self] result in
            switch result {
            case .success(let order):
                self?.showHUDSuccess(status: "Order received, \(order.name ?? "")")
            case .failure(let error):
                print(error.localizedDescription)
                self?.showHUDError(status: error.localizedDescription)
            }
        }
    }
}
