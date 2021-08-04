//
//  HomeViewController.swift
//  Foodie
//
//  Created by omokagbo on 28/05/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var foodCategoryCollectionView: UICollectionView!
    @IBOutlet weak var popularDishesCollectionView: UICollectionView!
    @IBOutlet weak var chefSpecialsCollectionView: UICollectionView!
    
    var categories: [DishCategory] = []
    var popularDishes: [Dish] = []
    var specialDishes: [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        fetchAllCategories()
    }
    
    func fetchAllCategories() {
        self.presentHUD(status: "Fetching Dishes")
        NetworkService.shared.fetchAllCategories { [weak self] result in
            switch result {
            case .success(let allDishes):
                self?.categories = allDishes.categories ?? []
                self?.popularDishes = allDishes.populars ?? []
                self?.specialDishes = allDishes.specials ?? []
                self?.dismissHUD()
                DispatchQueue.main.async {
                    self?.foodCategoryCollectionView.reloadData()
                    self?.popularDishesCollectionView.reloadData()
                    self?.chefSpecialsCollectionView.reloadData()
                }
            case .failure(let error):
                self?.dismissHUD()
                print(error.localizedDescription)
            }
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
            return categories.count
        case popularDishesCollectionView:
            return popularDishes.count
        case chefSpecialsCollectionView:
            return specialDishes.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case foodCategoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(categories[indexPath.row])
            return cell
        case popularDishesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDishesCollectionViewCell.identifier, for: indexPath) as? PopularDishesCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(popularDishes[indexPath.row])
            return cell
        case chefSpecialsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChefSpecialsCollectionViewCell.identifier, for: indexPath) as? ChefSpecialsCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(specialDishes[indexPath.row])
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
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = HomeDetailsViewController.instantiate(storyboardName: "HomeDetails")
            controller.dish = collectionView == popularDishesCollectionView ? popularDishes[indexPath.row] : specialDishes[indexPath.row]
            navigationController?.modalPresentationStyle = .fullScreen
            controller.dish = collectionView == popularDishesCollectionView ? popularDishes[indexPath.row] : specialDishes[indexPath.row]

            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
