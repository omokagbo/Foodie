//
//  OrdersViewController.swift
//  Foodie
//
//  Created by omokagbo on 13/06/2021.
//

import UIKit

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    let viewModel = OrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        registerCells()
        self.presentHUD(status: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupViewModelListeners()
    }
    
    private func registerCells() {
        ordersTableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
    
    private func setupViewModelListeners() {
        viewModel.fetchAllOrders()
        viewModel.notifyCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.dismissHUD()
                self?.ordersTableView.reloadData()
            }
        }
        
        viewModel.notifyError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showHUDError(status: message)
            }
        }
    }
}

extension OrdersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ordersTableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as? DishListTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: viewModel.orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count
    }
    
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = HomeDetailsViewController.instantiate(storyboardName: "HomeDetails")
        controller.viewModel.dish = viewModel.orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
}
