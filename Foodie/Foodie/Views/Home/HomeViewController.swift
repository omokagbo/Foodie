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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    private func registerNibs() {
        foodCategoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularDishesCollectionView.register(UINib(nibName: PopularDishesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularDishesCollectionViewCell.identifier)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case foodCategoryCollectionView:
            return categories.count
        case popularDishesCollectionView:
            return popularDishes.count
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
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
}
