//
//  RMTabBarController.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 19/05/23.
//

import UIKit

final class RMTabBarController: UITabBarController {
    
    // MARK: - PROPERTIES
    
    var navigationControllers: [UINavigationController] = []

    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - PUBLIC METHODS
    
    func addTab(viewController: UIViewController, title: String, image: UIImage) {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem = UITabBarItem(title: title,
                                                       image: image,
                                                       tag: navigationControllers.count)
        
        navigationControllers.append(navigationController)
        
        navigationController.navigationBar.isTranslucent = false
        
        setViewControllers(navigationControllers, animated: true)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupTabBar() {
        view.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}
