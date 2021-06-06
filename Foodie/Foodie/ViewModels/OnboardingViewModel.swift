//
//  OnboardingViewModel.swift
//  Foodie
//
//  Created by omokagbo on 28/05/2021.
//

import Foundation

class OnboardingViewModel {
    var slides = [
        OnboardingSlideModel(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.", image: #imageLiteral(resourceName: "slide2")),
        OnboardingSlideModel(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: #imageLiteral(resourceName: "slide1")),
        OnboardingSlideModel(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "slide3"))
    ]
}
