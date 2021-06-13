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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func placeOrderBtnTapped(_ sender: UIButton) {
    }
    

}
