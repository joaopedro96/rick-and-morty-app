//
//  RMEpisodesListViewProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

protocol RMEpisodesListViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: RMEpisodesListViewDelegate? { get set }
    func updateState(with viewState: RMEpisodesListViewState)
}

protocol RMEpisodesListViewDelegate: AnyObject {
    func getNextPage(with url: String)
    func didTapEpisodeCell()
}

extension RMEpisodesListViewProtocol where Self: UIView {
    var content: UIView { return self }
}
