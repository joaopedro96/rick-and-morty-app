//
//  RMCharacterDetailViewProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

protocol RMCharacterDetailViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: RMCharacterDetailViewDelegate? { get set }
    func updateState(with viewState: RMCharacterDetailViewState)
}

protocol RMCharacterDetailViewDelegate: AnyObject {
    func didTapBackButton()
}

extension RMCharacterDetailViewProtocol where Self: UIView {
    var content: UIView { return self }
}
