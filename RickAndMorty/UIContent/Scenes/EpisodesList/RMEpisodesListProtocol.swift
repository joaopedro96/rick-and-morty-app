//
//  RMEpisodesListViewProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

protocol RMEpisodesListViewModelProtocol: AnyObject {
    var viewController: RMEpisodesListViewControllerProtocol? { get }
    var viewState: RMEpisodesListViewState { get }
    func initState()
    func getNextPageData(with url: String)
}

protocol RMEpisodesListViewControllerProtocol: AnyObject {
    var delegate: RMEpisodesListViewControllerDelegate? { get set }
    func updateState(with viewState: RMEpisodesListViewState)
}

protocol RMEpisodesListViewControllerDelegate: AnyObject {
    func goToEpisodeDetailPage(from tabIndex: Int)
}
