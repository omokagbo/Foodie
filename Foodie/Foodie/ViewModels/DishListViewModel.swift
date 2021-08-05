//
//  DishListViewModel.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 05/08/2021.
//

import Foundation

class DishListViewModel {
    
    var category: DishCategory?
    var notifyError: ((String) -> Void)?
    var notifyCompletion: (() -> Void)?
    
    var dish: [Dish] = []
    
    func getDishCategories() {
        NetworkService.shared.fetchDishCategories(categoryId: category?.id ?? "") { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.dish = dishes
                self?.notifyCompletion?()
            case .failure(let error):
                self?.notifyError?(error.localizedDescription)
            }
        }
    }
    
}
