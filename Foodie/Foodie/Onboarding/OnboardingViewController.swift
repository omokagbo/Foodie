//
//  OnboardingViewController.swift
//  Foodie
//
//  Created by omokagbo on 28/05/2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    
    private var viewModel = OnboardingViewModel()
    var slides: [OnboardingSlideModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = viewModel.slides
        pageControl.numberOfPages = viewModel.slides.count
        updateViews()
    }
    
    private func updateViews() {
        viewModel.updateButton = { [weak self] nextBtnTitle, currentPage, skipBtnTitle in
            self?.pageControl.currentPage = currentPage
            self?.nextButton.setTitle(nextBtnTitle, for: .normal)
            self?.skipButton.setTitle(skipBtnTitle, for: .normal)
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if viewModel.currentPage == viewModel.slides.count - 1 {
            skipToHome()
        } else {
            viewModel.currentPage += 1
            let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        skipToHome()
    }
    
    private func skipToHome() {
        guard let homeNC = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as? UINavigationController else { return }
        homeNC.modalPresentationStyle = .fullScreen
        homeNC.modalTransitionStyle = .flipHorizontal
        present(homeNC, animated: true, completion: nil)
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(viewModel.slides[indexPath.row])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
}


extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        viewModel.currentPage = Int(scrollView.contentOffset.x / width)
    }
}
