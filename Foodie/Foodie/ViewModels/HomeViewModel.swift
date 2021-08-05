//
//  HomeViewModel.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 05/08/2021.
//

import Foundation

final class HomeViewModel {
    
    var categories: [DishCategory] = []
    var popularDishes: [Dish] = []
    var specialDishes: [Dish] = []
    
    var notifyCompletion: (() -> Void)?
    var notifyError: ((String) -> Void)?
    
     func fetchAllCategories() {
        NetworkService.shared.fetchAllCategories { [weak self] result in
            switch result {
            case .success(let allDishes):
                self?.categories = allDishes.categories ?? []
                self?.popularDishes = allDishes.populars ?? []
                self?.specialDishes = allDishes.specials ?? []
                self?.notifyCompletion?()
            case .failure(let error):
                self?.notifyError?(error.localizedDescription)
            }
        }
    }
    
}
