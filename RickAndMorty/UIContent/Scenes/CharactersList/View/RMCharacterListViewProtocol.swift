//
//  RMCharacterListViewProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

protocol RMCharacterListViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: RMCharacterListViewDelegate? { get set }
    func updateState(with viewState: RMCharacterListViewState)
}

protocol RMCharacterListViewDelegate: AnyObject {
    func didTapCharacter(_ selectedCharacter: RMCharacterDetailResponse)
    func getNextPage(with url: String)
}

extension RMCharacterListViewProtocol where Self: UIView {
    var content: UIView { return self }
}
