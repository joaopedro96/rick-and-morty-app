//
//  RMCharacterListViewProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

protocol RMCharacterListViewModelProtocol: AnyObject {
    var viewController: RMCharacterListViewControllerProtocol? { get }
    var viewState: RMCharacterListViewState { get }
    func initState()
    func getNextPageData(with url: String)
}

protocol RMCharacterListViewControllerProtocol: AnyObject {
    var delegate: RMCharacterListViewControllerDelegate? { get set }
    func updateState(with viewState: RMCharacterListViewState)
}

protocol RMCharacterListViewControllerDelegate: AnyObject {
    func goToCharacterDetailPage(with characterData: RMCharacterDetailResponse, from tabIndex: Int)
}
