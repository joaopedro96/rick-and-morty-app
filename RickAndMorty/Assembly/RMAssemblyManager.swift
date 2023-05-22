//
//  RMAssemblyManager.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 19/05/23.
//

import UIKit

final class RMAssemblyManager {
    
    // MARK: - PROPERTIES
        
    let flowManager: RMFlowManager
    
    // MARK: - INITIALIZERS
    
    init(flowManager: RMFlowManager = RMFlowManager(rootViewController: RMTabBarController())) {
        self.flowManager = flowManager
        flowManager.navigationBar.isHidden = true
        makeAssemble()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func makeAssemble() {
        guard let tabBar = flowManager.viewControllers.first as? RMTabBarController else {
            return
        }
        
        let characterVC = flowManager.makeCharacterListViewController()
        let episodeVC = flowManager.makeEpisodesListViewController()
        
        tabBar.addTab(viewController: characterVC,
                      title: "Character",
                      image: UIImage(systemName: "person") ?? .checkmark)
        
        tabBar.addTab(viewController: episodeVC,
                      title: "Episodes",
                      image: UIImage(systemName: "tv") ?? .checkmark)
        
        flowManager.tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
    }
}
