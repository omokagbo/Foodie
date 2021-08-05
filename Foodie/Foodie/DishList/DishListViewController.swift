//
//  DishListViewController.swift
//  Foodie
//
//  Created by omokagbo on 13/06/2021.
//

import UIKit

class DishListViewController: UIViewController {
    
    @IBOutlet weak var dishListTableView: UITableView!
    
    var category: DishCategory?
    
    var dish: [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.title
        registerCell()
        getDishCategories()
    }
    
    private func getDishCategories() {
        self.presentHUD(status: nil)
        NetworkService.shared.fetchDishCategories(categoryId: category?.id ?? "") { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.dismissHUD()
                self?.dish = dishes
                DispatchQueue.main.async {
                    self?.dishListTableView.reloadData()
                }
            case .failure(let error):
                self?.showHUDError(status: error.localizedDescription)
            }
        }
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
        controller.viewModel.dish = dish[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
