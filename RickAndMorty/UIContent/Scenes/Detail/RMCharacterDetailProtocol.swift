//
//  RMCharacterDetailProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

protocol RMCharacterDetailViewModelProtocol: AnyObject {
    var viewController: RMCharacterDetailViewControllerProtocol? { get }
    var viewState: RMCharacterDetailViewState { get }
    func initState()
}

protocol RMCharacterDetailViewControllerProtocol: AnyObject {
    var delegate: RMCharacterDetailViewControllerDelegate? { get set }
    func updateState(with viewState: RMCharacterDetailViewState)
}

protocol RMCharacterDetailViewControllerDelegate: AnyObject {
    func didTapGoBack(from tabIndex: Int)
}
