//
//  DishListViewController.swift
//  Foodie
//
//  Created by omokagbo on 13/06/2021.
//

import UIKit

class DishListViewController: UIViewController {
    
    @IBOutlet weak var dishListTableView: UITableView!
    
    let viewModel = DishListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.category?.title
        registerCell()
        setupViewModelListeners()
    }
    
    private func setupViewModelListeners() {
        viewModel.getDishCategories()
        self.presentHUD(status: nil)
        viewModel.notifyCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.dishListTableView.reloadData()
                self?.dismissHUD()
            }
        }
        
        viewModel.notifyError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showHUDError(status: message)
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
        cell.setup(with: viewModel.dish[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dish.count
    }
    
}

extension DishListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = HomeDetailsViewController.instantiate(storyboardName: "HomeDetails")
        controller.viewModel.dish = viewModel.dish[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}