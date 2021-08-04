//
//  DishListViewController.swift
//  Foodie
//
//  Created by omokagbo on 13/06/2021.
//

import UIKit

class DishListViewController: UIViewController {
    
    @IBOutlet weak var dishListTableView: UITableView!
    
    var category: DishCategory!
    
    var dish: [PopularDish] = [
        .init(id: "id1", name: "Garri", description: "Cassava flakes with a difference", image: "https://picsum.photos/200/200", calories: 94),
        .init(id: "id2", name: "Amala", description: "Amala with any soup of choice", image: "https://picsum.photos/200/200", calories: 224),
        .init(id: "id3", name: "Semo", description: "Finest semo in town", image: "https://picsum.photos/200/200", calories: 246),
        .init(id: "id4", name: "Fried Rice", description: "Fried rice with salad", image: "https://picsum.photos/200/200", calories: 128),
        .init(id: "id5", name: "Jollof Rice", description: "Nigerian jollof like you have never tasted", image: "https://picsum.photos/200/200", calories: 140)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCell()
    }
    
    private func registerCell() {
        dishListTableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
    
}

extension DishListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dishListTableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as? DishListTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: dish[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dish.count
    }
    
}

extension DishListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = HomeDetailsViewController.instantiate(storyboardName: "HomeDetails")
        controller.dish = dish[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
