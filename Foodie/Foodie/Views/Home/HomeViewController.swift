//
//  HomeViewController.swift
//  Foodie
//
//  Created by omokagbo on 28/05/2021.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var foodCategoryCollectionView: UICollectionView!
    @IBOutlet weak var popularDishesCollectionView: UICollectionView!
    @IBOutlet weak var chefSpecialsCollectionView: UICollectionView!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        viewModel.fetchAllCategories()
        setupViewModelListeners()
    }
    
    private func setupViewModelListeners() {
        self.presentHUD(status: "Fetching Dishes")
        viewModel.notifyCompletion = {
            self.dismissHUD()
            DispatchQueue.main.async { [weak self] in
                self?.foodCategoryCollectionView.reloadData()
                self?.popularDishesCollectionView.reloadData()
                self?.chefSpecialsCollectionView.reloadData()
            }
        }
        
        viewModel.notifyError = { [weak self] error in
            self?.showHUDError(status: error)
        }
        
    }
    
    private func registerNibs() {
        foodCategoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularDishesCollectionView.register(UINib(nibName: PopularDishesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularDishesCollectionViewCell.identifier)
        chefSpecialsCollectionView.register(UINib(nibName: ChefSpecialsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ChefSpecialsCollectionViewCell.identifier)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case foodCategoryCollectionView:
            return viewModel.categories.count
        case popularDishesCollectionView:
            return viewModel.popularDishes.count
        case chefSpecialsCollectionView:
            return viewModel.specialDishes.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case foodCategoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(viewModel.categories[indexPath.row])
            return cell
        case popularDishesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDishesCollectionViewCell.identifier, for: indexPath) as? PopularDishesCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(viewModel.popularDishes[indexPath.row])
            return cell
        case chefSpecialsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChefSpecialsCollectionViewCell.identifier, for: indexPath) as? ChefSpecialsCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(viewModel.specialDishes[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == foodCategoryCollectionView {
            let controller = DishListViewController.instantiate(storyboardName: "DishList")
            navigationController?.modalPresentationStyle = .fullScreen
            controller.viewModel.category = viewModel.categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = HomeDetailsViewController.instantiate(storyboardName: "HomeDetails")
            controller.viewModel.dish = collectionView == popularDishesCollectionView ? viewModel.popularDishes[indexPath.row] : viewModel.specialDishes[indexPath.row]
            navigationController?.modalPresentationStyle = .fullScreen
            controller.viewModel.dish = collectionView == popularDishesCollectionView ? viewModel.popularDishes[indexPath.row] : viewModel.specialDishes[indexPath.row]

            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
