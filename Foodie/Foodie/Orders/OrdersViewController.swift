//
//  OrdersViewController.swift
//  Foodie
//
//  Created by omokagbo on 13/06/2021.
//

import UIKit

class OrdersViewController: UIViewController {

    @IBOutlet weak var ordersTableView: UITableView!
    
    var orders: [Order] = [
        .init(id: "id1", name: "Emmanuel Omokagbo", dish: .init(id: "id1", name: "Garri", description: "Cassava flakes with a difference", image: "https://picsum.photos/100/200", calories: 94)),
        .init(id: "id2", name: "Emar Marabe", dish: .init(id: "id5", name: "Jollof Rice", description: "Nigerian jollof like you have never tasted", image: "https://picsum.photos/100/200", calories: 140)),
        .init(id: "id3", name: "John Doe", dish: .init(id: "id4", name: "Fried Rice", description: "Fried rice with salad", image: "https://picsum.photos/100/200", calories: 128))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        registerCells()
    }
    
    private func registerCells() {
        ordersTableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
}

extension OrdersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ordersTableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as? DishListTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = HomeDetailsViewController.instantiate(storyboardName: "HomeDetails")
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
}
