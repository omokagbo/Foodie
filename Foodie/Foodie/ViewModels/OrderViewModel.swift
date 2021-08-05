//
//  OrderViewModel.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 05/08/2021.
//

import Foundation

class OrderViewModel {
    
    var orders: [Order] = []
    
    var notifyError: ((String) -> Void)?
    var notifyCompletion: (() -> Void)?
    
    func fetchAllOrders() {
        NetworkService.shared.fetchAllOrders { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orders = orders
                self?.notifyCompletion?()
            case .failure(let error):
                self?.notifyError?(error.localizedDescription)
            }
        }
    }
    
}
