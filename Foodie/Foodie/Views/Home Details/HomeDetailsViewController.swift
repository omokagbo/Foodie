//
//  HomeDetailsViewController.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 13/06/2021.
//

import UIKit

final class HomeDetailsViewController: UIViewController {
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var dishDescription: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var orderButton: UIButton!
    
    let viewModel = HomeDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        dishImageView.kf.setImage(with: viewModel.dish?.image?.asURL)
        dishNameLbl.text = viewModel.dish?.name
        caloriesLbl.text = viewModel.dish?.formattedCalories
        dishDescription.text = viewModel.dish?.description
    }
    
    @IBAction func placeOrderBtnTapped(_ sender: UIButton) {
        setupViewModelListeners()
        viewModel.placeOrder(name: nameField.text)
    }
    
    private func setupViewModelListeners() {
        viewModel.notifyCompletion = { [weak self] message in
            DispatchQueue.main.async {
                self?.showHUDSuccess(status: message)
            }
        }
        
        viewModel.notifyError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showHUDError(status: error)
            }
        }
    }
}
