//
//  HomeViewController.swift
//  Foodie
//
//  Created by omokagbo on 28/05/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var foodCategoryCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "African Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "American Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "Asian Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "European Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id5", name: "Australian Dish", image: "https://picsum.photos/100/200")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    private func registerNibs() {
        foodCategoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }

}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(categories[indexPath.row])
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
}
