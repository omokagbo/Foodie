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
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "African Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "American Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "Asian Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "European Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id5", name: "Australian Dish", image: "https://picsum.photos/100/200")
    ]
    
    var popularDishes: [PopularDish] = [
        .init(id: "id1", name: "Garri", description: "Cassava flakes with a difference", image: "https://picsum.photos/100/200", calories: 94),
        .init(id: "id2", name: "Amala", description: "Amala with any soup of choice", image: "https://picsum.photos/100/200", calories: 224),
        .init(id: "id3", name: "Semo", description: "Finest semo in town", image: "https://picsum.photos/100/200", calories: 246),
        .init(id: "id4", name: "Fried Rice", description: "Fried rice with salad", image: "https://picsum.photos/100/200", calories: 128),
        .init(id: "id5", name: "Jollof Rice", description: "Nigerian jollof like you have never tasted", image: "https://picsum.photos/100/200", calories: 140)
    ]
    
    var specialDishes: [PopularDish] = [
        .init(id: "id1", name: "Plantain", description: "Fried plantain with sauce", image: "https://picsum.photos/100/200", calories: 150),
        .init(id: "id2", name: "Boli", description: "Roasted plantain that catches the eye", image: "https://picsum.photos/100/200", calories: 200),
        .init(id: "id3", name: "Pounded Yam", description: "Finest pounded yam with all kinds of soup", image: "https://picsum.photos/100/200", calories: 300),
        .init(id: "id4", name: "Pepper Soup", description: "Fish, bush meat, turkey or beef pepper soup", image: "https://picsum.photos/100/200", calories: 100),
        .init(id: "id5", name: "Coconut rice", description: "Coconut rice delicacy like you have never tasted before", image: "https://picsum.photos/100/200", calories: 140)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
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
}
