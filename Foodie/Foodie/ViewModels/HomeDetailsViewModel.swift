//
//  HomeDetailsViewModel.swift
//  Foodie
//
//  Created by omokagbo on 05/08/2021.
//

import Foundation

final class HomeDetailsViewModel {
    
    var dish: Dish?
    
    var notifyError: ((String) -> Void)?
    var notifyCompletion: ((String) -> Void)?
    
    func placeOrder(name: String?) {
        
        guard let name = name?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty,
              name != "" else {
                  self.notifyError?("Please enter your name")
                  return
              }
        
        NetworkService.shared.placeOrder(dishId: dish?.id ?? "", name: name) { [weak self] result in
            switch result {
            case .success(let order):
                self?.notifyCompletion?("Order received, \(order.name ?? "")")
            case .failure(let error):
                self?.notifyError?(error.localizedDescription)
            }
        }
        
    }
    
}
